class jenkins_plugin::plugins::base::jira {

  jenkins::plugin { 'jira':
    version => '3.0.8',
  }
}
