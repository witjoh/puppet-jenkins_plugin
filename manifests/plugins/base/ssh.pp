class jenkins_plugin::plugins::base::ssh {

  jenkins::plugin { 'ssh':
    version => '2.6.1',
  }
}
