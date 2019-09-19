# manages the installation of vnc related plugins and dependencies
#
class jenkins_plugin::plugins::nodejs {

  jenkins_plugin::plugins::install_groovy { 'nodejs': }
  include jenkins_plugin::plugins::base::nodejs
  include jenkins_plugin::plugins::base::config_file_provider
  include jenkins_plugin::plugins::base::structs
}
