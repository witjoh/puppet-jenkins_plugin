class jenkins_plugin::plugins::base::jsch (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'jsch':
    version => $version,
  }
}
