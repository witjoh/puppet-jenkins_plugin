class jenkins_plugin::plugins::base::pipeline_stage_step (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'pipeline-stage-step':
    version => $version,
  }
}
