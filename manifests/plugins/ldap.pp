# manages the installation of ldap plugin and dpemdencies
#
class jenkins_plugin::plugins::ldap {

  jenkins_plugin::plugins::install_groovy { 'ldap': }
  include jenkins_plugin::plugins::base::ldap
}
