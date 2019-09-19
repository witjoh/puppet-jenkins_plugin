class jenkins_plugin::plugins::base::nodejs {

  jenkins::plugin { 'nodejs':
    version => '1.3.3',
  }
}
