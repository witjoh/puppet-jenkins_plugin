# Manages the Jenkins blueocean-rest plugin
# 
class jenkins_plugin::plugins::base::blueocean_rest (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'blueocean-rest':
    version => $version,
  }
}

