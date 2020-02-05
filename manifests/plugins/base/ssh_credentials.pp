# Manages the Jenkins ssh-credentials plugin
#
class jenkins_plugin::plugins::base::ssh_credentials (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'ssh-credentials':
    version => $version,
  }
}
