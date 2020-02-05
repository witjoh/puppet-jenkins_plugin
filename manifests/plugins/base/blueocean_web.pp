# Manages the Jenkins blueocean-web plugin
# 
class jenkins_plugin::plugins::base::blueocean_web (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'blueocean-web':
    version => $version,
  }
}

