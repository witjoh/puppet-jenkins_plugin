class jenkins_plugin::plugins::base::pubsub_light {

  jenkins::plugin { 'pubsub-light':
    version => '1.12',
  }
}
