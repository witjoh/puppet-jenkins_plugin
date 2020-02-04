class jenkins_plugin::plugins::base::prescmbuildstep (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'preSCMbuildstep':
    version => $version,
  }
}
