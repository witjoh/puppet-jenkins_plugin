# Manages the Jenkins blueocean-personalization plugin
# 
class jenkins_plugin::plugins::base::blueocean_personalization (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'blueocean-personalization':
    version => $version,
  }
}

