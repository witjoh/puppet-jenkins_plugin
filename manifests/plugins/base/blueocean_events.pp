# Manages the Jenkins blueocean-events plugin
# 
class jenkins_plugin::plugins::base::blueocean_events (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'blueocean-events':
    version => $version,
  }
}

