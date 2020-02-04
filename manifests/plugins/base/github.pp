class jenkins_plugin::plugins::base::github (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'github':
    version => $version,
  }
}
