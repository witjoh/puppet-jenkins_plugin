class jenkins_plugin::plugins::base::ansicolor (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'ansicolor':
    version => $version,
  }
}
