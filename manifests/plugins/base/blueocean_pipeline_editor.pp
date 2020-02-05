# Manages the Jenkins blueocean-pipeline-editor plugin
# 
class jenkins_plugin::plugins::base::blueocean_pipeline_editor (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'blueocean-pipeline-editor':
    version => $version,
  }
}

