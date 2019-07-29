class jenkins_plugin::plugins::base::docker_workflow {

  jenkins::plugin { 'docker-workflow':
    version => '1.18',
  }
}
