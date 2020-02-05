# Manages the Jenkins build_pipeline plugin and dependencies
#
class jenkins_plugin::plugins::build_pipeline {

  include jenkins_plugin::plugins::base::build_pipeline_plugin
  include jenkins_plugin::plugins::base::parameterized_trigger
  include jenkins_plugin::plugins::base::conditional_buildstep
  include jenkins_plugin::plugins::base::run_condition
  include jenkins_plugin::plugins::base::maven_plugin
  include jenkins_plugin::plugins::base::javadoc
  include jenkins_plugin::plugins::base::apache_httpcomponents_client_4_api
  include jenkins_plugin::plugins::base::jsch
  include jenkins_plugin::plugins::base::junit
  include jenkins_plugin::plugins::base::mailer
  include jenkins_plugin::plugins::base::jquery
  include jenkins_plugin::plugins::base::matrix_project
  include jenkins_plugin::plugins::base::script_security

}
