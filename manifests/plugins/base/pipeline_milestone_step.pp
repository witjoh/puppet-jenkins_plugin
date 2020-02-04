class jenkins_plugin::plugins::base::pipeline_milestone_step (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'pipeline-milestone-step':
    version => $version,
  }
}
