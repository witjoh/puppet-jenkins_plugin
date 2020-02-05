# Manages the Jenkins docker-plugin plugin
#
class jenkins_plugin::plugins::base::docker_plugin (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'docker-plugin':
    version => $version,
  }
}
