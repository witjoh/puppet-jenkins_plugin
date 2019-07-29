class jenkins_plugin::plugins::base::docker_java_api {

  jenkins::plugin { 'docker-java-api':
    version => '3.0.14',
  }
}
