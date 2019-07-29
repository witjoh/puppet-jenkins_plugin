# manages the installation of vnc related plugins and dependencies
#
class jenkins_plugin::plugins::build_name_setter {

  include jenkins_plugin::plugins::base::build_name_setter
  include jenkins_plugin::plugins::base::matrix_project
  include jenkins_plugin::plugins::base::token_macro
}
