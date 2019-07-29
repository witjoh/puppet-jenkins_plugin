# manages the installation of credentials plugin and dependencies
#
class jenkins_plugin::plugins::credentials {

  include jenkins_plugin::plugins::base::structs
  include jenkins_plugin::plugins::base::credentials

}
