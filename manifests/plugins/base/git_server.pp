class jenkins_plugin::plugins::base::git_server (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'git-server':
    version => $version,
  }
}
