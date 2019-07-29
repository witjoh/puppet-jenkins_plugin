class jenkins_plugin::plugins::base::authentication_tokens {

  jenkins::plugin { 'authentication-tokens':
    version =>'1.3',
  }
}
