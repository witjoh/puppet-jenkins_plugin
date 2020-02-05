# Manages the Jenkins blueocean plugin
# 
class jenkins_plugin::plugins::base::blueocean (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'blueocean':
    version => $version,
  }
}
