# Helper class to install the global groovy on the master
#
# This is needed by multiple classes
#
class jenkins_plugin::config::master::groovy {
  jenkins_plugin::plugins::install_groovy { 'global': }
}
