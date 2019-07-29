# Manges the Jenkins Disk Usage plugin and dependencies
#
class jenkins_plugin::plugins::base::disk_usage {
  jenkins::plugin { 'disk-usage':
    version => '0.28',
  }
}
