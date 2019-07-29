class jenkins_plugin::plugins::base::blueocean_jira {

  jenkins::plugin { 'blueocean-jira':
    version => '1.17.0',
  }
}

