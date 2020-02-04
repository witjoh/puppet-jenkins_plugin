class jenkins_plugin::plugins::base::credentials_binding (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'credentials-binding':
    version => $version,
  }
}
