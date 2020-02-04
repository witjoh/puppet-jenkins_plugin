# manages the installation of role_strategy related plugins and dependencies
#
class jenkins_plugin::plugins::role_strategy {

  #jenkins_plugin::plugins::install_groovy { 'role-strategy': }
  include jenkins_plugin::plugins::base::role_strategy
  include jenkins_plugin::plugins::base::matrix_auth
}
