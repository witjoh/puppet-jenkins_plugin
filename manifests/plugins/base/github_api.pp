class jenkins_plugin::plugins::base::github_api (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'github-api':
    version => $version,
  }
}
