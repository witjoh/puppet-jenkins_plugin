# Manages the Jenkins copyartifact plugin and dependencies
#
class jenkins_plugin::plugins::copyartifact {

  include jenkins_plugin::plugins::base::copyartifact
  include jenkins_plugin::plugins::base::apache_httpcomponents_client_4_api
  include jenkins_plugin::plugins::base::matrix_project
  include jenkins_plugin::plugins::base::scm_api
  # provided by the upstream module
  # include jenkins_plugin::plugins::base::structs

}
