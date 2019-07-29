class jenkins_plugin::plugins::base::cloudbees_bitbucket_branch_source {

  jenkins::plugin { 'cloudbees-bitbucket-branch-source':
    version => '2.4.5',
  }
}
