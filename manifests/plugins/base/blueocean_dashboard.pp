class jenkins_plugin::plugins::base::blueocean_dashboard {

  jenkins::plugin { 'blueocean-dashboard':
    version => '1.17.0',
  }
}

