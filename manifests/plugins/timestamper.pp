# manages the installation of x related plugins and dependencies
#
class jenkins_plugin::plugins::timestamper {

  #jenkins_plugin::plugins::install_groovy { 'xvnc': }
  include jenkins_plugin::plugins::base::timestamper
  include jenkins_plugin::plugins::base::workflow_api
  include jenkins_plugin::plugins::base::workflow_step_api
  include jenkins_plugin::plugins::base::scm_api
  include jenkins_plugin::plugins::base::structs
}
