class jenkins_plugin::plugins::base::jquery {

  jenkins::plugin { 'jquery':
    version => '1.12.4-0',
  }
}
