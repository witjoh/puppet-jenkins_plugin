# Manages the Jenkins publish-over-ssh plugin
#
class jenkins_plugin::plugins::base::publish_over_ssh (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'publish-over-ssh':
    version => $version,
  }
}
