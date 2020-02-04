class jenkins_plugin::plugins::base::blueocean_github_pipeline (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'blueocean-github-pipeline':
    version => $version,
  }
}

