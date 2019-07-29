class jenkins_plugin::plugins::base::ssh_slaves {

  jenkins::plugin { 'ssh-slaves':
    version => '1.30.0',
  }
}
