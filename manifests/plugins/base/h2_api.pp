# Manages the Jenkins h2-api plugin
#
class jenkins_plugin::plugins::base::h2_api (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'h2-api':
    version => $version,
  }
}
