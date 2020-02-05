# Manages the Jenkins metrics-graphite plugin
#
class jenkins_plugin::plugins::base::metrics_graphite (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'metrics-graphite':
    version => $version,
  }
}
