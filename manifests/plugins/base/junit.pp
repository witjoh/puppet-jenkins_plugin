class jenkins_plugin::plugins::base::junit {

  jenkins::plugin { 'junit':
    version => '1.28',
  }
}
