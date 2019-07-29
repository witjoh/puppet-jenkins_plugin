class jenkins_plugin::plugins::base::pipeline_stage_step {

  jenkins::plugin { 'pipeline-stage-step':
    version => '2.3',
  }
}
