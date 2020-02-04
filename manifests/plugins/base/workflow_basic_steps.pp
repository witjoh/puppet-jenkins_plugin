class jenkins_plugin::plugins::base::workflow_basic_steps (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'workflow-basic-steps':
    version => $version,
  }
}

