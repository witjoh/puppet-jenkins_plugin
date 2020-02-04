class jenkins_plugin::plugins::base::github_branch_source (
  Jenkins_plugin::SemVer $version,
) {
  jenkins::plugin { 'github-branch-source':
    version => $version,
  }
}

