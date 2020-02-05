# Manages the Jenkins external-monitor-job plugin
#
class jenkins_plugin::plugins::base::external_monitor_job (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'external-monitor-job':
    version => $version,
  }
}
