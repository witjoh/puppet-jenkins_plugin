class jenkins_plugin::plugins::base::jira (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'jira':
    version => $version,
  }
}
