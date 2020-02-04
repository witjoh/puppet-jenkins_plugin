class jenkins_plugin::plugins::base::blueocean_jira (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'blueocean-jira':
    version => $version,
  }
}

