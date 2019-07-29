class jenkins_plugin::plugins::base::workflow_aggregator {

  jenkins::plugin { 'workflow-aggregator':
    version => '2.6',
  }
}
