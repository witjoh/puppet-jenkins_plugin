class jenkins_plugin::plugins::base::ws_cleanup {

  jenkins::plugin { 'ws-cleanup':
    version => '0.37',
  }
}
