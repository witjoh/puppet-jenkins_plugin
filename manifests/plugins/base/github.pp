class jenkins_plugin::plugins::base::github {

  jenkins::plugin { 'github':
    version => '1.29.4',
  }
}
