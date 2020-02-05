# Manages the Jenkins throttle-concurrents plugin
#
class jenkins_plugin::plugins::base::throttle_concurrents (
    Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'throttle-concurrents':
    version => $version,
  }
}
