# Manages the Jenkins build-timeout plugin
# 
class jenkins_plugin::plugins::base::build_timeout (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'build-timeout':
    version => $version,
  }
}
