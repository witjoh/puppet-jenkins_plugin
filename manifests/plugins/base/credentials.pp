# Manages the Jenkins credentials plugin
# 
class jenkins_plugin::plugins::base::credentials (
  Jenkins_plugin::SemVer $version,
) {

  # this plugin is managed by jenkins upstream.
  # keep this class empty to avoid duplicate resource declaration
  jenkins::plugin { 'credentials':
    version => $version,
  }
}
