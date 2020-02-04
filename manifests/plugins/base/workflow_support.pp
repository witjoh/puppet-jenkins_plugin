class jenkins_plugin::plugins::base::workflow_support (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'workflow-support':
    version => $version,
  }
}
