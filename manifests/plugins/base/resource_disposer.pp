class jenkins_plugin::plugins::base::resource_disposer {

  jenkins::plugin { 'resource-disposer':
    version => '0.12',
  }
}
