class jenkins_plugin::plugins::base::blueocean_config {

  jenkins::plugin { 'blueocean-config':
    version => '1.17.0',
  }
}

