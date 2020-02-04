class jenkins_plugin::plugins::base::timestamper (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'timestamper':
    version => $version,
  }
}
