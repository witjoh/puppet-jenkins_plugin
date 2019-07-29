class jenkins_plugin::plugins::base::ssh_credentials {

  jenkins::plugin { 'ssh-credentials':
    version => '1.17',
  }
}
