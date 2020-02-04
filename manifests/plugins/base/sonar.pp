class jenkins_plugin::plugins::base::sonar (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'sonar':
    version => $version,
  }
}
