class jenkins_plugin::plugins::base::build_name_setter {

  jenkins::plugin { 'build-name-setter':
    version => '1.7.1',
  }
}
