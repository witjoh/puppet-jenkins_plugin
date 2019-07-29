class jenkins_plugin::plugins::base::rebuild {

  jenkins::plugin { 'rebuild':
    version => '1.31',
  }
}
