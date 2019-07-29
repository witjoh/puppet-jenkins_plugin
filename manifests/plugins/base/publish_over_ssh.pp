class jenkins_plugin::plugins::base::publish_over_ssh {

  jenkins::plugin { 'publish-over-ssh':
    version => '1.20.1',
  }
}
