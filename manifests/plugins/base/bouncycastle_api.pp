class jenkins_plugin::plugins::base::bouncycastle_api {

  jenkins::plugin { 'bouncycastle-api':
    version => '2.17',
  }
}
