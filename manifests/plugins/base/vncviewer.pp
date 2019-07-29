class jenkins_plugin::plugins::base::vncviewer {

  jenkins::plugin { 'vncviewer':
    version => '1.5',
  }
}
