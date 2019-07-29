class jenkins_plugin::plugins::base::docker_plugin {

  jenkins::plugin { 'docker-plugin':
    version => '1.1.6',
  }
}
