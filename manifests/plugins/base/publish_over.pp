# Manages the Jenkins publish-over plugin
#
class jenkins_plugin::plugins::base::publish_over (
  Jenkins_plugin::Semver $version,
) {

  jenkins::plugin { 'publish-over':
    version => $version,
  }
}
