# manages the installation of build-timeout plugin and dependencies
#
class jenkins_plugin::plugins::build_timeout {

  include jenkins_plugin::plugins::base::build_timeout
  include jenkins_plugin::plugins::base::token_macro
}
