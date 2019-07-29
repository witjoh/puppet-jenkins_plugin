class jenkins_plugin::plugins::base::github_branch_source {
  jenkins::plugin { 'github-branch-source':
    version => '2.5.3',
  }
}

