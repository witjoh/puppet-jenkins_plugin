class jenkins_plugin::plugins::base::workflow_multibranch (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'workflow-multibranch':
    version => $version,
  }
}
