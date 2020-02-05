# Manages the Jenkins pipeline-rest-api plugin
#
class jenkins_plugin::plugins::base::pipeline_rest_api (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'pipeline-rest-api':
    version => $version,
  }
}
