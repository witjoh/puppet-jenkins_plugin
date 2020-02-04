class jenkins_plugin::plugins::base::pipeline_model_definition (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'pipeline-model-definition':
    version => $version,
  }
}
