class jenkins_plugin::plugins::base::git (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'git':
    version => $version,
  }
}
