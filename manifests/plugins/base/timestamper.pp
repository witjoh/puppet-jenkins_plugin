class jenkins_plugin::plugins::base::timestamper {

  jenkins::plugin { 'timestamper':
    version => '1.10',
  }
}
