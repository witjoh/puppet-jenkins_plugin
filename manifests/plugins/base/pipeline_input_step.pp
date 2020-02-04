class jenkins_plugin::plugins::base::pipeline_input_step (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'pipeline-input-step':
    version => $version,
  }
}
