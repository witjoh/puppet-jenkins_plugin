class jenkins_plugin::plugins::base::pipeline_model_declarative_agent (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'pipeline-model-declarative-agent':
    version => $version,
  }
}
