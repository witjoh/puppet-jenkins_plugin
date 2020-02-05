# Manages the Jenkins cloudbees-bitbucket-branch-source plugin
# 
class jenkins_plugin::plugins::base::cloudbees_bitbucket_branch_source (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'cloudbees-bitbucket-branch-source':
    version => $version,
  }
}
