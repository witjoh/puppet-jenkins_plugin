class jenkins_plugin::plugins::base::parameterized_trigger {

  jenkins::plugin { 'parameterized-trigger':
    version => '2.35.2',
  }
}
