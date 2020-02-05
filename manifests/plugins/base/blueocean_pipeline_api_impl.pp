# Manages the Jenkins blueocean-pipeline-api-impl plugin
# 
class jenkins_plugin::plugins::base::blueocean_pipeline_api_impl (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'blueocean-pipeline-api-impl':
    version => $version,
  }
}

