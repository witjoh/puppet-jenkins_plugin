class jenkins_plugin::plugins::base::workflow_api (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'workflow-api':
    version => $version,
  }
}
