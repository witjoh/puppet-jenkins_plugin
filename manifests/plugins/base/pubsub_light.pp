# Manages the Jenkins pubsub-light plugin
#
class jenkins_plugin::plugins::base::pubsub_light (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'pubsub-light':
    version => $version,
  }
}
