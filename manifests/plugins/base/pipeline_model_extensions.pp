class jenkins_plugin::plugins::base::pipeline_model_extensions {

  jenkins::plugin { 'pipeline-model-extensions':
    version => '1.3.9',
  }
}
