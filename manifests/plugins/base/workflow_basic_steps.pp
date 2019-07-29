class jenkins_plugin::plugins::base::workflow_basic_steps {

  jenkins::plugin { 'workflow-basic-steps':
    version => '2.18',
  }
}

