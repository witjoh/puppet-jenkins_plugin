class jenkins_plugin::plugins::base::github_api {

  jenkins::plugin { 'github-api':
    version => '1.95',
  }
}
