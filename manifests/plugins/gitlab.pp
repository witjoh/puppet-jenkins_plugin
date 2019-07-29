# this class manages the puppet jenkins specific plugins
#
class jenkins_plugin::plugins::gitlab {

  jenkins_plugin::plugins::install_groovy { 'gitlab-plugin': }

  include jenkins_plugin::plugins::base::gitlab_plugin
  include jenkins_plugin::plugins::base::workflow_job
  include jenkins_plugin::plugins::base::git
  include jenkins_plugin::plugins::base::git_client
  include jenkins_plugin::plugins::base::workflow_scm_step
  include jenkins_plugin::plugins::base::apache_httpcomponents_client_4_api
  include jenkins_plugin::plugins::base::jsch
  include jenkins_plugin::plugins::base::ssh_credentials
  include jenkins_plugin::plugins::base::mailer
  include jenkins_plugin::plugins::base::matrix_project
  include jenkins_plugin::plugins::base::display_url_api
  include jenkins_plugin::plugins::base::junit
  include jenkins_plugin::plugins::base::script_security
  include jenkins_plugin::plugins::base::workflow_support
  include jenkins_plugin::plugins::base::scm_api
  include jenkins_plugin::plugins::base::workflow_step_api
  include jenkins_plugin::plugins::base::workflow_api
  include jenkins_plugin::plugins::base::apache_httpcomponents_client_4_api
}
