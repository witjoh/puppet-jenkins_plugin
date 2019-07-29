class jenkins_plugin::plugins::base::git_server {

  jenkins::plugin { 'git-server':
    version => '1.7',
  }
}
