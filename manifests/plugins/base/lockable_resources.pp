class jenkins_plugin::plugins::base::lockable_resources (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'lockable-resources':
    version => $version,
  }
}
