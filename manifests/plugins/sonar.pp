# this class manages the puppet jenkins specific plugins
#
class jenkins_plugin::plugins::sonar {

  jenkins_plugin::plugins::install_groovy { 'sonar': }

  include jenkins_plugin::plugins::base::sonar
  include jenkins_plugin::plugins::base::credentials
  include jenkins_plugin::plugins::base::plain_credentials
}
