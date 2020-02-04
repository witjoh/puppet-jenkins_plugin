class jenkins_plugin::plugins::base::trilead_api (
  Jenkins_plugin::SemVer $version,
) {

  # this plugin is managed by jenkins upstream.
  # keep this class empty to avoid duplicate resource declaration
  jenkins::plugin { 'trilead-api':
    version => $version,
  }
}
