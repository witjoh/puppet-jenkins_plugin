# Manges the Jenkins Disk Usage plugin and dependencies
#
class jenkins_plugin::plugins::base::http_request (
  Jenkins_plugin::SemVer $version,
) {
  jenkins::plugin { 'http-request':
    version => $version,
  }
}
