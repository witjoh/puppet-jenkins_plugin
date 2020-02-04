# manages the installation of core plugins installed by the jenkins core war
#
class jenkins_plugin::plugins::core {

  # jenkins moves plugins outside the core, and install those on startup
  # this way we can still update those plugins.
  if ($facts['jenkins_version']) and (versioncmp($facts['jenkins_version'], '2.190') >= 0 ) {
    include jenkins_plugin::plugins::base::windows_slaves
    include jenkins_plugin::plugins::base::bouncycastle_api
  }
  if ($facts['jenkins_version']) and (versioncmp($facts['jenkins_version'], '2.204') >= 0 ) {
    include jenkins_plugin::plugins::base::external_monitor_job
    include jenkins_plugin::plugins::base::matrix_auth
    include jenkins_plugin::plugins::base::antisamy_markup_formatter
    include jenkins_plugin::plugins::base::pam_auth
  }
}
