class jenkins_plugin::plugins::base::javadoc {

  jenkins::plugin { 'javadoc':
    version => '1.5',
  }
}
