# Manages the Jenkins http-request plugin
#
class jenkins_plugin::plugins::base::http_request (
  Jenkins_plugin::SemVer $version,
) {
  jenkins::plugin { 'http-request':
    version => $version,
  }
}
