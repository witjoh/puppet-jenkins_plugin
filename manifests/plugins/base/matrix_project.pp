class jenkins_plugin::plugins::base::matrix_project {

  jenkins::plugin { 'matrix-project':
    version => '1.14',
  }
}
