class jenkins_plugin::plugins::base::jdk_tool (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'jdk-tool':
    version => $version,
  }
}
