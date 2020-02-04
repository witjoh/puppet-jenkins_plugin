class jenkins_plugin::plugins::base::nodejs (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'nodejs':
    version => $version,
  }
}
