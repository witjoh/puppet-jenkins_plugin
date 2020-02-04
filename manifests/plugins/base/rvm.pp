class jenkins_plugin::plugins::base::rvm (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'rvm':
    version => $version,
  }
}
