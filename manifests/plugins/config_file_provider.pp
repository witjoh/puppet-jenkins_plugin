# Manages the Jenkins config_file_provider plugin and dependencies
#
class jenkins_plugin::plugins::config_file_provider {

  jenkins_plugin::plugins::install_groovy { 'config-file-provider': }

  include jenkins_plugin::plugins::base::config_file_provider
  include jenkins_plugin::plugins::base::credentials
  include jenkins_plugin::plugins::base::ssh_credentials
  include jenkins_plugin::plugins::base::structs
  include jenkins_plugin::plugins::base::token_macro
}
