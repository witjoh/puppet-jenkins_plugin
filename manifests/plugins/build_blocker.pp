# Manages the Jenkins build_blocker plugin and dependencies
#
class jenkins_plugin::plugins::build_blocker {

  include jenkins_plugin::plugins::base::build_blocker_plugin
  include jenkins_plugin::plugins::base::matrix_project

}
