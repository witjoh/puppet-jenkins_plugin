class jenkins_plugin::plugins::base::greenballs (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'greenballs':
    version => $version,
  }
}
