class jenkins_plugin::plugins::base::pipeline_milestone_step {

  jenkins::plugin { 'pipeline-milestone-step':
    version => '1.3.1',
  }
}
