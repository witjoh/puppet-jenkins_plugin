class jenkins_plugin::plugins::base::pipeline_input_step {

  jenkins::plugin { 'pipeline-input-step':
    version => '2.10',
  }
}
