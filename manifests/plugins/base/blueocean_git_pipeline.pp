# Manages the Jenkins blueocean-git-pipeline plugin
# 
class jenkins_plugin::plugins::base::blueocean_git_pipeline (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'blueocean-git-pipeline':
    version => $version,
  }
}

