# manages the installation of vnc related plugins and dependencies
#
class jenkins_plugin::plugins::ssh {

  jenkins_plugin::plugins::install_groovy { 'ssh': }
  include jenkins_plugin::plugins::base::ssh
  include jenkins_plugin::plugins::base::jsch
  include jenkins_plugin::plugins::base::ssh_credentials
  include jenkins_plugin::plugins::base::credentials
  include jenkins_plugin::plugins::base::trilead_api
}
