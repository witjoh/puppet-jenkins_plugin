class jenkins_plugin::plugins::base::workflow_multibranch {

  jenkins::plugin { 'workflow-multibranch':
    version => '2.21',
  }
}
