class jenkins_plugin::plugins::base::pipeline_stage_view (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin {'pipeline-stage-view':
    version => $version,
  }
}
