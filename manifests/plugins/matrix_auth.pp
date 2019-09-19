# manages the installation of matrix-auth related plugins and dependencies
#
class jenkins_plugin::plugins::matrix_auth {

  jenkins_plugin::plugins::install_groovy { 'matrix-auth': }
  include jenkins_plugin::plugins::base::matrix_auth
}
