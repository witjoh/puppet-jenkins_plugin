# Manges the Jenkins Publish over SSH plugin and dpendencies
#
class jenkins_plugin::plugins::publish_over_ssh {

  jenkins_plugin::plugins::install_groovy { 'publish-over-ssh': }

  include jenkins_plugin::plugins::base::publish_over
  include jenkins_plugin::plugins::base::jsch
  include jenkins_plugin::plugins::base::publish_over_ssh
  include jenkins_plugin::plugins::base::structs
}
