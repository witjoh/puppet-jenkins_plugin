# manages the installation of vnc related plugins and dependencies
#
class jenkins_plugin::plugins::testinprogress{

  #jenkins_plugin::plugins::install_groovy { 'xvnc': }
  include jenkins_plugin::plugins::base::testinprogress
}
