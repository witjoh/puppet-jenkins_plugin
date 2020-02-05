# Manages the Jenkins build-blocker-plugin plugin
# 
class jenkins_plugin::plugins::base::build_blocker_plugin (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'build-blocker-plugin':
    version => $version,
  }
}
