class jenkins_plugin::plugins::base::docker_commons {

  jenkins::plugin { 'docker-commons':
    version => '1.15',
  }
}
