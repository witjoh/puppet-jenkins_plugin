class jenkins_plugin::plugins::base::resource_disposer (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'resource-disposer':
    version => $version,
  }
}
