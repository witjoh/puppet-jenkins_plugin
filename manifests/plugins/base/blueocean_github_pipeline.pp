class jenkins_plugin::plugins::base::blueocean_github_pipeline {

  jenkins::plugin { 'blueocean-github-pipeline':
    version => '1.17.0',
  }
}

