# manages the installation of credentials plugin and dependencies
#
class jenkins_plugin::plugins::build_publisher {

  include jenkins_plugin::plugins::base::build_publisher
  include jenkins_plugin::plugins::base::maven_plugin
  include jenkins_plugin::plugins::base::junit
  include jenkins_plugin::plugins::base::apache_httpcomponents_client_4_api
  include jenkins_plugin::plugins::base::javadoc
  include jenkins_plugin::plugins::base::mailer
  include jenkins_plugin::plugins::base::token_macro
  include jenkins_plugin::plugins::base::jsch
  include jenkins_plugin::plugins::base::ssh_credentials
  include jenkins_plugin::plugins::base::credentials
  include jenkins_plugin::plugins::base::trilead_api
  include jenkins_plugin::plugins::base::structs
  include jenkins_plugin::plugins::base::workflow_api
  include jenkins_plugin::plugins::base::workflow_step_api
  include jenkins_plugin::plugins::base::script_security
  include jenkins_plugin::plugins::base::scm_api
  include jenkins_plugin::plugins::base::display_url_api
  include jenkins_plugin::plugins::base::matrix_project

}
