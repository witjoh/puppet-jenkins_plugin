class jenkins_plugin::plugins::email_ext {

  include jenkins_plugin::plugins::base::email_ext
  include jenkins_plugin::plugins::base::script_security
  include jenkins_plugin::plugins::base::junit
  include jenkins_plugin::plugins::base::mailer
  include jenkins_plugin::plugins::base::matrix_project
  include jenkins_plugin::plugins::base::token_macro
  ## structs is installed by the upstream module
  # include jenkins_plugin::plugins::base::structs
}
