class jenkins_plugin::plugins::base::blueocean_git_pipeline {

  jenkins::plugin { 'blueocean-git-pipeline':
    version => '1.17.0',
  }
}

