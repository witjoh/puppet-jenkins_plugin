# Manges the Jenkins Disk Usage plugin and dependencies
#
class jenkins_plugin::plugins::base::http_request {
  jenkins::plugin { 'http-request':
    version => '1.8.22',
  }
}
