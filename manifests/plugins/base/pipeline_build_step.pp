# Manages the Jenkins pipeline-build-step plugin
#
class jenkins_plugin::plugins::base::pipeline_build_step (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'pipeline-build-step':
    version => $version,
  }
}
