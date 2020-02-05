# Manages the Jenkins blueocean-autofavorite plugin
# 
class jenkins_plugin::plugins::base::blueocean_autofavorite (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'blueocean-autofavorite':
    version => $version,
  }
}

