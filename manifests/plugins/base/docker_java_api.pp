class jenkins_plugin::plugins::base::docker_java_api (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'docker-java-api':
    version => $version,
  }
}
