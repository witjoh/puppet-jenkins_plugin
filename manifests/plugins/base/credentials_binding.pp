class jenkins_plugin::plugins::base::credentials_binding {

  jenkins::plugin { 'credentials-binding':
    version => '1.19',
  }
}
