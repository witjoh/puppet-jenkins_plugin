class jenkins_plugin::plugins::base::xvnc (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'xvnc':
    version => $version,
  }
}
