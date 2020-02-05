# Manages the Jenkins trilead-api plugin
#
class jenkins_plugin::plugins::base::trilead_api (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'trilead-api':
    version => $version,
  }
}
