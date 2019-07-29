class jenkins_plugin::plugins::base::plain_credentials {

  jenkins::plugin { 'plain-credentials':
    version => '1.5',
  }
}
