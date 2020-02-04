class jenkins_plugin::plugins::base::monitoring (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'monitoring':
    version => $version,
  }
}
