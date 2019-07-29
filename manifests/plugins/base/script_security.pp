class jenkins_plugin::plugins::base::script_security {

  jenkins::plugin { 'script-security':
    version => '1.60',
  }
}
