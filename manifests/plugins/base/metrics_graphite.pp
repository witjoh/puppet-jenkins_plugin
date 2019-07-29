class jenkins_plugin::plugins::base::metrics_graphite {

  jenkins::plugin { 'metrics-graphite':
    version => '3.0.0',
  }
}
