class jenkins_plugin::plugins::base::build_publisher (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'build-publisher':
    version => $version,
  }
}
