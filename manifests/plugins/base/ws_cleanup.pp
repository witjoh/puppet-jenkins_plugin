class jenkins_plugin::plugins::base::ws_cleanup (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'ws-cleanup':
    version => $version,
  }
}
