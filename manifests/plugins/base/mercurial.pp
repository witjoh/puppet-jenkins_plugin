class jenkins_plugin::plugins::base::mercurial {

  jenkins::plugin { 'mercurial':
    version => '2.6',
  }
}
