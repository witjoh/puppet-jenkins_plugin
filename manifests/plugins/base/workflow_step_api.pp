class jenkins_plugin::plugins::base::workflow_step_api {

  jenkins::plugin { 'workflow-step-api':
    version => '2.20',
  }
}
