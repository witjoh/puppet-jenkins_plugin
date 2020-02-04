class jenkins_plugin::plugins::base::sse_gateway (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'sse-gateway':
    version => $version,
  }
}
