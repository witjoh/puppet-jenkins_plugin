class jenkins_plugin::plugins::base::maven_plugin {

  jenkins::plugin { 'maven-plugin':
    version => '3.3',
  }
}
