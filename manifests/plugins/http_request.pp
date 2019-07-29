# manages the installation of vnc related plugins and dependencies
#
class jenkins_plugin::plugins::http_request {

  #jenkins_plugin::plugins::install_groovy { 'xvnc': }
  include jenkins_plugin::plugins::base::http_request
  include jenkins_plugin::plugins::base::apache_httpcomponents_client_4_api
}
