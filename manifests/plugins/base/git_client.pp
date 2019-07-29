class jenkins_plugin::plugins::base::git_client {

  jenkins::plugin { 'git-client':
    version => '2.8.0',
  }
}
