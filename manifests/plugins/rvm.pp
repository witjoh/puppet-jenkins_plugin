# Installs rmv plugin and dependencies
#
class jenkins_plugin::plugins::rvm {

  include jenkins_plugin::plugins::base::rvm
  include jenkins_plugin::plugins::base::ruby_runtime
  include jenkins_plugin::plugins::base::token_macro
}
