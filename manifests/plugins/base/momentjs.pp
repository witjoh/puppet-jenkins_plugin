class jenkins_plugin::plugins::base::momentjs (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'momentjs':
    version => $version,
  }
}
