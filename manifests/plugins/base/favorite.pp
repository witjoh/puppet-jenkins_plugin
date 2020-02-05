# Manages the Jenkins favorite plugin
#
class jenkins_plugin::plugins::base::favorite (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'favorite':
    version => $version,
  }
}
