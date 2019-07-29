class jenkins_plugin::plugins::base::sonar {

  jenkins::plugin { 'sonar':
    version => '2.9',
  }
}
