class jenkins_plugin::plugins::base::pipeline_build_step {

  jenkins::plugin { 'pipeline-build-step':
    version => '2.9',
  }
}
