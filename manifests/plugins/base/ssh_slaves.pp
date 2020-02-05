# Manages the Jenkins ssh-slaves plugin
#
class jenkins_plugin::plugins::base::ssh_slaves (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'ssh-slaves':
    version => $version,
  }
}
