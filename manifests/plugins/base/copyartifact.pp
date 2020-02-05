# Manages the Jenkins copyartifact plugin
# 
class jenkins_plugin::plugins::base::copyartifact (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'copyartifact':
    version => $version,
  }
}
