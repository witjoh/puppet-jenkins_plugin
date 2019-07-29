# This class configures the jenkins SSHD at bootstrapping jenkins
# We try to solve a chicken-egg problem.  It only initialise the file
# right after jenkins package installation and before first service startup
#
class jenkins_plugin::config::master::bootstrap_sshd (
  String  $owner = 'jenkins',
  String  $group = 'jenkins',
  Integer $port  = 35836,
) {

  $content = @("EOT")
    <?xml version='1.1' encoding='UTF-8'?>
    <org.jenkinsci.main.modules.sshd.SSHD>
      <port>${port}</port>
    </org.jenkinsci.main.modules.sshd.SSHD>
    | EOT

  file { '/var/lib/jenkins/org.jenkinsci.main.modules.sshd.SSHD.xml':
    ensure  => file,
    replace => false,
    content => $content,
    owner   => $owner,
    group   => $group,
    require => Class['jenkins::package'],
    before  => Class['jenkins::service'],
  }
}
