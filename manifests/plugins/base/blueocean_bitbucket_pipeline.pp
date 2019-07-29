class jenkins_plugin::plugins::base::blueocean_bitbucket_pipeline {

  jenkins::plugin { 'blueocean-bitbucket-pipeline':
    version => '1.17.0',
  }
}

