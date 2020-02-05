# Manages the Jenkins blueocean-dashboard plugin
#
class jenkins_plugin::plugins::base::blueocean_dashboard (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'blueocean-dashboard':
    version => $version,
  }
}

