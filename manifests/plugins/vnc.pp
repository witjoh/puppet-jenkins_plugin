# manages the installation of vnc related plugins and dependencies
#
class jenkins_plugin::plugins::vnc {

  jenkins_plugin::plugins::install_groovy { 'xvnc': }
  include jenkins_plugin::plugins::base::xvnc
  include jenkins_plugin::plugins::base::vncviewer
}
