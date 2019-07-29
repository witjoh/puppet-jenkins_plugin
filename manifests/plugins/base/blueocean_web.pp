class jenkins_plugin::plugins::base::blueocean_web {

  jenkins::plugin { 'blueocean-web':
    version => '1.17.0',
  }
}

