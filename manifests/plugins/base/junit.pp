class jenkins_plugin::plugins::base::junit (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'junit':
    version => $version,
  }
}
