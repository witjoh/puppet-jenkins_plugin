class jenkins_plugin::plugins::base::plain_credentials (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'plain-credentials':
    version => $version,
  }
}
