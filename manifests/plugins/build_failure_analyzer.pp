# manages the  Build Failure Analyzer Plugin
#
class jenkins_plugin::plugins::build_failure_analyzer {

  include jenkins_plugin::plugins::base::build_failure_analyzer
  include jenkins_plugin::plugins::base::junit
  include jenkins_plugin::plugins::base::apache_httpcomponents_client_4_api
  include jenkins_plugin::plugins::base::jackson2_api
  include jenkins_plugin::plugins::base::matrix_project
}
