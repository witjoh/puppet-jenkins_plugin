# Manages the Jenkins htmlpublisher plugin and dependencies
#
class jenkins_plugin::plugins::htmlpublisher {

  include jenkins_plugin::plugins::base::htmlpublisher
  include jenkins_plugin::plugins::base::workflow_step_api
  include jenkins_plugin::plugins::base::matrix_project

}
