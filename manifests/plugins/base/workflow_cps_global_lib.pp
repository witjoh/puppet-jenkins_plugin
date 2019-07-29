class jenkins_plugin::plugins::base::workflow_cps_global_lib {

  jenkins::plugin { 'workflow-cps-global-lib':
    version => '2.13',
  }
}
