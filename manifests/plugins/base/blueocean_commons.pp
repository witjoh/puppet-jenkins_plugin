# Manages the Jenkins blueocean-commons plugin
# 
class jenkins_plugin::plugins::base::blueocean_commons (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'blueocean-commons':
    version => $version,
  }
}

