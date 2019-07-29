# Installs rmv plugin and dependencies
#
class jenkins_plugin::plugins::metrics_graphite {

  jenkins_plugin::plugins::install_groovy { 'metrics-graphite': }

  include jenkins_plugin::plugins::base::metrics_graphite
  include jenkins_plugin::plugins::base::metrics
  include jenkins_plugin::plugins::base::variant
  include jenkins_plugin::plugins::base::jackson2_api
}
