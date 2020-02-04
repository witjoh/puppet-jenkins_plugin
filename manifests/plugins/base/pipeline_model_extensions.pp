class jenkins_plugin::plugins::base::pipeline_model_extensions (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'pipeline-model-extensions':
    version => $version,
  }
}
