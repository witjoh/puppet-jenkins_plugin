# Manges the Jenkins docker plugin and dpendencies
#
class jenkins_plugin::plugins::docker {

  # jenkins_plugin::plugins::install_groovy { 'docker': }

  include jenkins_plugin::plugins::base::docker_plugin
  include jenkins_plugin::plugins::base::docker_commons
  include jenkins_plugin::plugins::base::apache_httpcomponents_client_4_api
  include jenkins_plugin::plugins::base::bouncycastle_api
  include jenkins_plugin::plugins::base::docker_java_api
  include jenkins_plugin::plugins::base::durable_task
  include jenkins_plugin::plugins::base::ssh_slaves
  include jenkins_plugin::plugins::base::token_macro
  include jenkins_plugin::plugins::base::credentials
  include jenkins_plugin::plugins::base::ssh_credentials
  include jenkins_plugin::plugins::base::jackson2_api
  include jenkins_plugin::plugins::base::structs
  include jenkins_plugin::plugins::base::authentication_tokens
  include jenkins_plugin::plugins::base::credentials_binding
  include jenkins_plugin::plugins::base::workflow_step_api
  include jenkins_plugin::plugins::base::plain_credentials
}
