# The pipeline-maven Integration plugin and dependencies
#
class jenkins_plugin::plugins::pipeline_maven_integration {
  include jenkins_plugin::plugins::base::pipeline_maven
  include jenkins_plugin::plugins::base::workflow_job
  include jenkins_plugin::plugins::base::workflow_step_api
  include jenkins_plugin::plugins::base::branch_api
  include jenkins_plugin::plugins::base::cloudbees_folder
  include jenkins_plugin::plugins::base::config_file_provider
  include jenkins_plugin::plugins::base::workflow_api
  include jenkins_plugin::plugins::base::script_security
  include jenkins_plugin::plugins::base::scm_api
  include jenkins_plugin::plugins::base::ssh_credentials
  include jenkins_plugin::plugins::base::token_macro
  include jenkins_plugin::plugins::base::workflow_support
  include jenkins_plugin::plugins::base::credentials
  include jenkins_plugin::plugins::base::structs
  include jenkins_plugin::plugins::base::h2_api

}
