class jenkins_plugin::plugins::base::durable_task {

  jenkins::plugin { 'durable-task':
    version => '1.29',
  }
}
