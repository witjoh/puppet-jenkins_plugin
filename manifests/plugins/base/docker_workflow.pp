# Manages the Jenkins docker-workflow plugin
#
class jenkins_plugin::plugins::base::docker_workflow (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'docker-workflow':
    version => $version,
  }
}
