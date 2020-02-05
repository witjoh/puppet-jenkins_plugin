# Manages the Jenkins blazemeterjenkinsplugin plugin and dependencies
#
class jenkins_plugin::plugins::blazemeterjenkinsplugin {

  include jenkins_plugin::plugins::base::blazemeterjenkinsplugin
  include jenkins_plugin::plugins::base::workflow_step_api
  include jenkins_plugin::plugins::base::credentials
  include jenkins_plugin::plugins::base::structs
}
