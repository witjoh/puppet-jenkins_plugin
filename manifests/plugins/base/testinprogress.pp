class jenkins_plugin::plugins::base::testinprogress {

  jenkins::plugin { 'testInProgress':
    version => '1.4',
  }
}
