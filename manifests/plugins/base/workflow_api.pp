class jenkins_plugin::plugins::base::workflow_api {

  jenkins::plugin { 'workflow-api':
    version => '2.35',
  }
}
