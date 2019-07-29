class jenkins_plugin::plugins::base::xvnc {

  jenkins::plugin { 'xvnc':
    version => '1.24',
  }
}
