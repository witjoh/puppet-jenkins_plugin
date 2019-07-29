class jenkins_plugin::plugins::base::build_timeout {

  jenkins::plugin { 'build-timeout':
    version => '1.19',
  }
}
