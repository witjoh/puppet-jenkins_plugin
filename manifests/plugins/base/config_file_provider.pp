# Manages the Jenkins config-file-provider plugin
# 
class jenkins_plugin::plugins::base::config_file_provider (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'config-file-provider':
    version => $version,
  }
}
