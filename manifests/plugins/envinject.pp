# Manages the Jenkins envinject plugin and dependencies
#
class jenkins_plugin::plugins::envinject {

  include jenkins_plugin::plugins::base::envinject
  include jenkins_plugin::plugins::base::envinject_api
  include jenkins_plugin::plugins::base::matrix_project

}
