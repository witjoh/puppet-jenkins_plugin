class jenkins_plugin::plugins::base::maven_plugin (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'maven-plugin':
    version => $version,
  }
}
