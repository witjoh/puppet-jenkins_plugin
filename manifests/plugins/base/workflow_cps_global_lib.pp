class jenkins_plugin::plugins::base::workflow_cps_global_lib (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'workflow-cps-global-lib':
    version => $version,
  }
}
