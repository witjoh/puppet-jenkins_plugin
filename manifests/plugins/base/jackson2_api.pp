class jenkins_plugin::plugins::base::jackson2_api (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin {'jackson2-api':
    version => $version,
  }
}
