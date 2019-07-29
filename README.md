# Jenkins_plugin Module

#### config directory

The Config directory contains helper classes that will abstract some
configuration settings, which are used in the main master and/or slave class,
but also can be used in special purpose master/slaves setup.

the config/groovy class installs java libraries, which can be used in jobDSL and 
other je kins based groovy script.

The config/master directory contains configuration classes specific for Jenkins masters.

The config/slave directory contains the configuration classes specific for Jenkins slaves.

The config/plugin directory contains the puppetcode acting like 'wrappers' around the
the groovy files used to configure installed jenkins plugins.  Here you will find Classes for
singular configuration parts, and defines for those parts that could have multiple entries for
the same configuration, like eg. multiple ssh servers for the Publish over SSH plugin.

#### plugins directory

The plugins directory contains all plugins, inlcuding there dependencies that could be installed
on a Jenkins Master.  All classe in this directory may only contain includes of 'plugins/base/*.pp'
classes.  In this base directory, every class represents just one plugin, setting the supported verion
of this plugin only.

This way, we avoid duplicate resource definition even if we include multiple plugins having the same
dependencie.

### The groovy scripts

in the files/groovy/plugins directory, you will find the groovy files used by the puppet code found in
manifests/config/plugins.

Every puppet class/define will use above groovy files using the jenkins::cli::exec define in a simular way.

Groovy files are organized in a specific way :

**groovy/plugins/<jenkins plugin name>/puppet_helper_<jenkins plugin name>.groovy**

Whenever a plugin is installed, the puppet code will also install the corresponding groovy file.

````
groovy/plugins/
├── cloudbees-folder
│   └── puppet_helper_cloudbees-folder.groovy
├── gitlab-plugin
│   └── puppet_helper_gitlab-plugin.groovy
├── global
│   └── puppet_helper_global.groovy
├── ldap
│   └── puppet_helper_ldap.groovy
├── lib
│   └── Plib.groovy
├── metrics-graphite
│   └── puppet_helper_metrics-graphite.groovy
├── publish-over-ssh
│   └── puppet_helper_publish-over-ssh.groovy
└── xvnc
    └── puppet_helper_xvnc.groovy
````

Groovy files provide actions which can be executed against the jenkins master to configure
plugins.

A groovy actions is roughly named like :

<plugin>_<action>_<config part>

Following actions are mostly provided :

* set : add or update a plugin congifuration
* del : remove a plugin configuration
* get : retreive a plugin configuration
* insync : check if a configuration is up to date

A groovy actions needs just one or more arguments.

The actions requiring only one argument just expect one string as that argument.

Whenever multiple arguments are needed, they must be past as a string in the following form:

**argument1:value1 argument2:value2 argument3:'value3 with space' ......**

Internally this will be translated to a groovy map. Order here is of no importance.

#### Groovy and Puppet code

To make this work, we need to patch the upstream module so we can provide it the desired groovy script to use:

````
diff --git a/manifests/cli/exec.pp b/manifests/cli/exec.pp
index b1e6155..490f9f6 100644
--- a/manifests/cli/exec.pp
+++ b/manifests/cli/exec.pp
@@ -4,8 +4,9 @@
 # CLI.
 #
 define jenkins::cli::exec(
-  Optional[String] $unless        = undef,
+  Optional[String]       $unless  = undef,
   Variant[String, Array] $command = $title,
+  Optional[String]       $plugin  = undef,
 ) {

   include ::jenkins
@@ -13,22 +14,42 @@ define jenkins::cli::exec(
   include ::jenkins::cli::reload

   Class['jenkins::cli_helper']
-    -> Jenkins::Cli::Exec[$title]
-      -> Anchor['jenkins::end']
+  -> Jenkins::Cli::Exec[$title]
+  -> Anchor['jenkins::end']
+
+  if $plugin {
+    $port = jenkins_port()
+    $prefix = jenkins_prefix()
+    $_helper_cmd = join(
+      delete_undef_values([
+        '/bin/cat',
+        "${jenkins::libdir}/groovy/plugins/${plugin}/puppet_helper_${plugin}.groovy",
+        '|',
+        '/usr/bin/java',
+        "-jar ${::jenkins::cli::jar}",
+        "-s http://127.0.0.1:${port}${prefix}",
+        $::jenkins::_cli_auth_arg,
+        'groovy =',
+        ]),
+        ' '
+    )
+  } else {
+    $_helper_cmd = $::jenkins::cli_helper::helper_cmd
+  }

   # $command may be either a string or an array due to the use of flatten()
   $run = join(
     delete_undef_values(
       flatten([
-        $::jenkins::cli_helper::helper_cmd,
+        $_helper_cmd,
         $command,
-      ])
+        ])
     ),
     ' '
   )

   if $unless {
-    $environment_run = [ "HELPER_CMD=eval ${::jenkins::cli_helper::helper_cmd}" ]
+    $environment_run = [ "HELPER_CMD=eval ${_helper_cmd}" ]
   } else {
     $environment_run = undef
   }
diff --git a/spec/defines/jenkins_cli_exec_spec.rb b/spec/defines/jenkins_cli_exec_spec.rb
index 396bfad..71162d7 100644
--- a/spec/defines/jenkins_cli_exec_spec.rb
+++ b/spec/defines/jenkins_cli_exec_spec.rb
@@ -111,4 +111,31 @@ describe 'jenkins::cli::exec', type: :define do
       end
     end
   end # unless_cli_helper =>
+
+  describe 'plugin =>' do
+    let(:helper_cmd) { '/bin/cat /usr/lib/jenkins/groovy/plugins/thing/puppet_helper_thing.groovy | /usr/bin/java -jar /usr/lib/jenkins/jenkins-cli.jar -s http://127.0.0.1:8080 groovy =' }
+    context 'foo' do
+      let(:params) { { plugin: 'thing' } }
+      it do
+        is_expected.to contain_exec('foo').with(
+          command: "#{helper_cmd} foo",
+          tries: 10,
+          try_sleep: 10,
+          unless: nil,
+        )
+      end
+    end
+    context 'plugin unless' do
+      let(:params) { { plugin: 'thing', unless: 'foo' } }
+      it do
+        is_expected.to contain_exec('foo').with(
+          command: "#{helper_cmd} foo",
+          environment: ["HELPER_CMD=eval #{helper_cmd}"],
+          tries: 10,
+          try_sleep: 10,
+          unless: 'foo',
+        )
+      end
+    end
+  end
 end
````

In general a wrapper consist of following elements :

command attribute : set or delete with arguments
unless attribute : get or insync action, to check if configuration changes are needed.

Since the unless attribute uses the bash 'eval' function, it often happen the unless command
fails because the eval function does some naste stuff woth quotes.  This can be fixed using the
puppet **shellquote()** function for the arguments passes to the groovy action.

````
define jenkins_plugin::config::plugins::folder (
  String                    $folder       = $title,
  Enum['absent', 'present'] $ensure       = 'present',
  Boolean                   $force_remove = false,
) {

  Jenkins::Cli::Exec {
    plugin => 'cloudbees-folder',
  }

  if $ensure == 'present' {
    jenkins::cli::exec { "setFolder-${title}":
      command => "setFolder ${folder}",
      unless  => "\$HELPER_CMD getFolder ${folder} | /bin/grep ${folder}",
    }
  } else {
    jenkins::cli::exec { "removeFolder-${title}":
      command => "removeFolder ${folder} ${bool2str($force_remove)}",
      unless  => "[[ -z \$(\$HELPER_CMD getFolder ${folder} | /bin/grep ${folder}) ]]",
    }
  }
}
````

### remarks using this module

* When setting the jenkins url, the hostname must be resolvable, otherwise the CLI won't work
* Setting the sshd port to random, will generate a failed puppetrun the first time after the jenkins master is restarted.


References and handy tips concerning groovy and jenkins :

* https://gist.github.com/zouzias/bf447ab020955ac70db5db5521c3d5b9
* https://github.com/samrocketman/jenkins-bootstrap-shared/blob/master/scripts/configure-jenkins-settings.groovy
* https://github.com/Accenture/adop-jenkins/blob/master/resources/init.groovy.d/adop_ldap.groovy
* https://github.com/zouzias/useful-jenkins-groovy-init-scripts
* https://javadoc.jenkins-ci.org/jenkins/model/Jenkins.html
* https://javadoc.jenkins-ci.org/jenkins/model/JenkinsLocationConfiguration.html#JenkinsLocationConfiguration--
* https://pghalliday.com/jenkins/groovy/sonar/chef/configuration/management/2014/09/21/some-useful-jenkins-groovy-scripts.html

## Notes on groovy.

We noticed that the unless of the exec, called by jenkins::cli::exec removed the quotes around a multi word string, giving the effect
that the string is not passed as a 1 string, but split by words.
The command is respecting the quotes we gave in the argument settings, but since the unless in the jenkins::cli::exec uses the bash eval functions, those
quotes are stripped, making unless command fail.
To avoud this, one need to pass the arguments throught the shellquote() puppet function only for the unless attribute.  Problem solved.

https://serverfault.com/questions/269592/bash-quotes-getting-stripped-when-a-command-is-passed-as-argument-to-a-function
