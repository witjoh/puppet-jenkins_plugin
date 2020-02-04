class jenkins_plugin::plugins::base::blazemeterjenkinsplugin (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'BlazeMeterJenkinsPlugin':
    version => $version,
  }
}
