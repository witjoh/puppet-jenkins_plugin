class jenkins_plugin::plugins::base::pipeline_model_declarative_agent {

  jenkins::plugin { 'pipeline-model-declarative-agent':
    version => '1.1.1',
  }
}
