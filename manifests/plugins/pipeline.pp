# manages the installation of ldap plugin and dpemdencies
#
class jenkins_plugin::plugins::pipeline {

  include jenkins_plugin::plugins::base::workflow_aggregator
  include jenkins_plugin::plugins::base::lockable_resources
  include jenkins_plugin::plugins::base::workflow_api
  include jenkins_plugin::plugins::base::workflow_basic_steps
  include jenkins_plugin::plugins::base::workflow_cps_global_lib
  include jenkins_plugin::plugins::base::workflow_cps
  include jenkins_plugin::plugins::base::command_launcher
  include jenkins_plugin::plugins::base::workflow_durable_task_step
  include jenkins_plugin::plugins::base::workflow_job
  include jenkins_plugin::plugins::base::workflow_multibranch
  include jenkins_plugin::plugins::base::workflow_scm_step
  include jenkins_plugin::plugins::base::workflow_step_api
  include jenkins_plugin::plugins::base::pipeline_stage_view
  include jenkins_plugin::plugins::base::jackson2_api
  include jenkins_plugin::plugins::base::pipeline_input_step
  include jenkins_plugin::plugins::base::pipeline_build_step
  include jenkins_plugin::plugins::base::pipeline_milestone_step
  include jenkins_plugin::plugins::base::pipeline_stage_step
  include jenkins_plugin::plugins::base::pipeline_model_definition
  include jenkins_plugin::plugins::base::pipeline_model_extensions
  include jenkins_plugin::plugins::base::ace_editor
  include jenkins_plugin::plugins::base::jquery_detached
  include jenkins_plugin::plugins::base::durable_task
  include jenkins_plugin::plugins::base::docker_workflow
  include jenkins_plugin::plugins::base::docker_commons
  include jenkins_plugin::plugins::base::credentials_binding
  include jenkins_plugin::plugins::base::plain_credentials
  include jenkins_plugin::plugins::base::pipeline_model_api
  include jenkins_plugin::plugins::base::pipeline_model_declarative_agent
  include jenkins_plugin::plugins::base::pipeline_stage_tags_metadata
  include jenkins_plugin::plugins::base::cloudbees_folder
  include jenkins_plugin::plugins::base::workflow_support
  include jenkins_plugin::plugins::base::scm_api
  include jenkins_plugin::plugins::base::apache_httpcomponents_client_4_api
  include jenkins_plugin::plugins::base::mailer
  include jenkins_plugin::plugins::base::git_server
  include jenkins_plugin::plugins::base::git_client
  include jenkins_plugin::plugins::base::script_security
  include jenkins_plugin::plugins::base::branch_api
  include jenkins_plugin::plugins::base::jsch
  include jenkins_plugin::plugins::base::ssh_credentials
  include jenkins_plugin::plugins::base::authentication_tokens
  include jenkins_plugin::plugins::base::momentjs
  include jenkins_plugin::plugins::base::pipeline_rest_api
  include jenkins_plugin::plugins::base::handlebars
  include jenkins_plugin::plugins::base::pipeline_graph_analysis
  ## structs is installed by the upstream module
  # include jenkins_plugin::plugins::base::structs
}
