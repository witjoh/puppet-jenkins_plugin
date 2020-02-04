class jenkins_plugin::plugins::base::matrix_auth (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'matrix-auth':
    version => $version,
  }
}
