class jenkins_plugin::plugins::base::branch_api (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'branch-api':
    version => $version,
  }
}
