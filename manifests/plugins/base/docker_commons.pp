# Manages the Jenkins docker-commons plugin
#
class jenkins_plugin::plugins::base::docker_commons (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'docker-commons':
    version => $version,
  }
}
