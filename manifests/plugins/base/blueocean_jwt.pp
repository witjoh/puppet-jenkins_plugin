class jenkins_plugin::plugins::base::blueocean_jwt {

  jenkins::plugin { 'blueocean-jwt':
    version => '1.17.0',
  }
}

