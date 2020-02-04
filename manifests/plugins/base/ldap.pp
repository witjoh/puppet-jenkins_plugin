class jenkins_plugin::plugins::base::ldap (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'ldap':
    version => $version,
  }
}
