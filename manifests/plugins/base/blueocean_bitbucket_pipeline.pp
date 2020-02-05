# Manages the Jenkins blueocean-bitbucket-pipeline plugin
# 
class jenkins_plugin::plugins::base::blueocean_bitbucket_pipeline (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'blueocean-bitbucket-pipeline':
    version => $version,
  }
}

