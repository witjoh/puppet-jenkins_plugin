class jenkins_plugin::plugins::base::publish_over {

  jenkins::plugin { 'publish-over':
    version => '0.22',
  }
}
