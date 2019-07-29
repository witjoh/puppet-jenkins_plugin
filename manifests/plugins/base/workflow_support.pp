class jenkins_plugin::plugins::base::workflow_support {

  jenkins::plugin { 'workflow-support':
    version => '3.3',
  }
}
