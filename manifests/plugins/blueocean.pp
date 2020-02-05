# Manages the Jenkins blueocean plugin and dependencies
#
class jenkins_plugin::plugins::blueocean {

  include jenkins_plugin::plugins::base::blueocean_autofavorite
  include jenkins_plugin::plugins::base::blueocean_bitbucket_pipeline
  include jenkins_plugin::plugins::base::blueocean_commons
  include jenkins_plugin::plugins::base::blueocean_config
  include jenkins_plugin::plugins::base::blueocean_core_js
  include jenkins_plugin::plugins::base::blueocean_dashboard
  include jenkins_plugin::plugins::base::blueocean_display_url
  include jenkins_plugin::plugins::base::blueocean_events
  include jenkins_plugin::plugins::base::blueocean_github_pipeline
  include jenkins_plugin::plugins::base::blueocean_git_pipeline
  include jenkins_plugin::plugins::base::blueocean_i18n
  include jenkins_plugin::plugins::base::blueocean_jira
  include jenkins_plugin::plugins::base::blueocean_jwt
  include jenkins_plugin::plugins::base::blueocean_personalization
  include jenkins_plugin::plugins::base::blueocean_pipeline_api_impl
  include jenkins_plugin::plugins::base::blueocean_pipeline_editor
  include jenkins_plugin::plugins::base::blueocean
  include jenkins_plugin::plugins::base::blueocean_rest_impl
  include jenkins_plugin::plugins::base::blueocean_rest
  include jenkins_plugin::plugins::base::blueocean_web
  include jenkins_plugin::plugins::base::jenkins_design_language
  include jenkins_plugin::plugins::base::pipeline_build_step
  include jenkins_plugin::plugins::base::pipeline_milestone_step

  include jenkins_plugin::plugins::base::git
  include jenkins_plugin::plugins::base::blueocean_pipeline_scm_api
  include jenkins_plugin::plugins::base::workflow_api
  include jenkins_plugin::plugins::base::workflow_cps
  include jenkins_plugin::plugins::base::workflow_durable_task_step
  include jenkins_plugin::plugins::base::workflow_job
  include jenkins_plugin::plugins::base::workflow_multibranch
  include jenkins_plugin::plugins::base::workflow_step_api
  include jenkins_plugin::plugins::base::workflow_support
  include jenkins_plugin::plugins::base::branch_api
  include jenkins_plugin::plugins::base::credentials
  include jenkins_plugin::plugins::base::github_branch_source
  include jenkins_plugin::plugins::base::htmlpublisher
  include jenkins_plugin::plugins::base::pipeline_graph_analysis
  include jenkins_plugin::plugins::base::pipeline_input_step
  include jenkins_plugin::plugins::base::pipeline_stage_step
  include jenkins_plugin::plugins::base::plain_credentials
  include jenkins_plugin::plugins::base::scm_api
  include jenkins_plugin::plugins::base::pipeline_model_definition
  include jenkins_plugin::plugins::base::pipeline_stage_tags_metadata

  include jenkins_plugin::plugins::base::display_url_api
  include jenkins_plugin::plugins::base::junit
  include jenkins_plugin::plugins::base::cloudbees_folder
  include jenkins_plugin::plugins::base::mailer
  include jenkins_plugin::plugins::base::favorite

  include jenkins_plugin::plugins::base::variant
  include jenkins_plugin::plugins::base::git_client
  include jenkins_plugin::plugins::base::bouncycastle_api
  include jenkins_plugin::plugins::base::command_launcher
  include jenkins_plugin::plugins::base::jdk_tool

  include jenkins_plugin::plugins::base::script_security

  include jenkins_plugin::plugins::base::apache_httpcomponents_client_4_api
  include jenkins_plugin::plugins::base::cloudbees_bitbucket_branch_source
  include jenkins_plugin::plugins::base::pubsub_light
  include jenkins_plugin::plugins::base::sse_gateway

  include jenkins_plugin::plugins::base::github_api
  include jenkins_plugin::plugins::base::jackson2_api
  include jenkins_plugin::plugins::base::jira

  include jenkins_plugin::plugins::base::favorite
  include jenkins_plugin::plugins::base::token_macro
  include jenkins_plugin::plugins::base::matrix_project

  include jenkins_plugin::plugins::base::github
  include jenkins_plugin::plugins::base::mercurial
  include jenkins_plugin::plugins::base::handy_uri_templates_2_api
}
