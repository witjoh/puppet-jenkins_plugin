# Manages the Jenkins metrics plugin
#
class jenkins_plugin::plugins::base::metrics (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'metrics':
    version => $version,
  }
}
