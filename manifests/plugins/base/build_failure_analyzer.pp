class jenkins_plugin::plugins::base::build_failure_analyzer (
  Jenkins_plugin::SemVer $version,
) {
  jenkins::plugin { 'build-failure-analyzer':
    version => $version,
  }
}
