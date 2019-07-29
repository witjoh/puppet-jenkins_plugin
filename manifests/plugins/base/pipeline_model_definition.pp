class jenkins_plugin::plugins::base::pipeline_model_definition {

  jenkins::plugin { 'pipeline-model-definition':
    version => '1.3.9',
  }
}
