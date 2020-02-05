# Manages the Jenkins ssh plugin
#
class jenkins_plugin::plugins::base::ssh (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'ssh':
    version => $version,
  }
}
