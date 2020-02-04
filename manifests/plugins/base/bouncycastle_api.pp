class jenkins_plugin::plugins::base::bouncycastle_api (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'bouncycastle-api':
    version => $version,
  }
}
