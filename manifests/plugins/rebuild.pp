# Manages the Jenkins rebuild plugin and dependencies
#
class jenkins_plugin::plugins::rebuild {

  include jenkins_plugin::plugins::base::rebuild
  include jenkins_plugin::plugins::base::matrix_project

}
