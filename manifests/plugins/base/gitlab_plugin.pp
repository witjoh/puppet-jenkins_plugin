class jenkins_plugin::plugins::base::gitlab_plugin (
  Jenkins_plugin::SemVer $version,
) {
  jenkins::plugin { 'gitlab-plugin':
    version => $version,
  }
}

