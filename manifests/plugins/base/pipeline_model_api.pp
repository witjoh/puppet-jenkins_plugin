# Manages the Jenkins pipeline-model-api plugin
#
class jenkins_plugin::plugins::base::pipeline_model_api (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'pipeline-model-api':
    version => $version,
  }
}
