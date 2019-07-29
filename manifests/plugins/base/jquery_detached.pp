class jenkins_plugin::plugins::base::jquery_detached {

  jenkins::plugin { 'jquery-detached':
    version => '1.2.1',
  }
}
