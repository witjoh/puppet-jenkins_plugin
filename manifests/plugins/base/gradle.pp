class jenkins_plugin::plugins::base::gradle {

  jenkins::plugin { 'gradle':
    version => '1.32',
  }
}
