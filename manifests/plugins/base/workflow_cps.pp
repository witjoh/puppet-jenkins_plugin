class jenkins_plugin::plugins::base::workflow_cps {

  jenkins::plugin { 'workflow-cps':
    version => '2.70',
  }
}
