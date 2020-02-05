# Manages the Jenkins generic_webhook plugin and dependencies
#
class jenkins_plugin::plugins::generic_webhook {

  include jenkins_plugin::plugins::base::generic_webhook_trigger

}
