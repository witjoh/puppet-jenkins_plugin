class jenkins_plugin::plugins::base::git {

  jenkins::plugin { 'git':
    version => '3.10.0',
  }
}
