class jenkins_plugin::plugins::base::workflow_scm_step {

  jenkins::plugin { 'workflow-scm-step':
    version => '2.9',
  }
}
