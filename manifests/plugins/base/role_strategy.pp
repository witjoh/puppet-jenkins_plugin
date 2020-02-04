class jenkins_plugin::plugins::base::role_strategy (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'role-strategy':
    version => $version,
  }
}
