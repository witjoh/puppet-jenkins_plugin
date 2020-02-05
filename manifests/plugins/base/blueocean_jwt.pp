# Manages the Jenkins blueocean-jwt plugin
# 
class jenkins_plugin::plugins::base::blueocean_jwt (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'blueocean-jwt':
    version => $version,
  }
}

