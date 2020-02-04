class jenkins_plugin::plugins::base::run_condition (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'run-condition':
    version => $version,
  }
}
