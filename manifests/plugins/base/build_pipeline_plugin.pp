# Manages the Jenkins build-pipeline-plugin plugin
# 
class jenkins_plugin::plugins::base::build_pipeline_plugin (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'build-pipeline-plugin':
    version => $version,
  }
}
