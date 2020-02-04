class jenkins_plugin::plugins::base::parameterized_trigger (
    Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'parameterized-trigger':
    version => $version,
  }
}
