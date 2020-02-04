class jenkins_plugin::plugins::base::workflow_job (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'workflow-job':
    version => $version,
  }
}
