class jenkins_plugin::plugins::base::matrix_auth {

  jenkins::plugin { 'matrix-auth':
    version => '2.4.2',
  }
}
