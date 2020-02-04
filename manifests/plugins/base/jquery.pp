class jenkins_plugin::plugins::base::jquery (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'jquery':
    version => $version,
  }
}
