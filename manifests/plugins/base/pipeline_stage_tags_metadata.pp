class jenkins_plugin::plugins::base::pipeline_stage_tags_metadata (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'pipeline-stage-tags-metadata':
    version => $version,
  }
}
