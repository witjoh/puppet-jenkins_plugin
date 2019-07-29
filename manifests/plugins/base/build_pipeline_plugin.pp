class jenkins_plugin::plugins::base::build_pipeline_plugin {

  jenkins::plugin { 'build-pipeline-plugin':
    version => '1.5.8',
  }
}
