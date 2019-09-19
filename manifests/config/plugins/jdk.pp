# @summary Adds a SSH remote Site in the Configure System section
#
# @param name [String] Name of the JDK installation
#
# @param javahome [Stdlib::Absolutepath] The Java Home directory.
#
define jenkins_plugin::config::plugins::jdk (
  Stdlib::Absolutepath      $javahome,
  Enum['present', 'absent'] $ensure = 'present',
  String                    $jdkname = $title,
) {

  ensure_resource('jenkins_plugin::plugins::install_groovy', 'jdk')

  Jenkins::Cli::Exec {
    plugin => 'jdk',
  }

  $arguments = "name:'${jdkname}' javahome:${javahome}"

  if $ensure == 'present' {
    jenkins::cli::exec { "set_jdk_installation-${title}":
      command => "set_jdk_installation ${arguments}",
      unless  => "\$HELPER_CMD insync_jdk_installation ${shellquote($arguments)} | /bin/grep '^true$'",
    }

  } else {
    jenkins::cli::exec { "del_jdk_installation-${title}":
      command => "del_jdk_installation ${arguments}",
      unless  => "[[ -z \$(\$HELPER_CMD get_jdk_installation ${arguments} | /bin/grep '${jdkname}') ]]",
    }
  }
}
