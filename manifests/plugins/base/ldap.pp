class jenkins_plugin::plugins::base::ldap {

  jenkins::plugin { 'ldap':
    version => '1.20',
  }
}
