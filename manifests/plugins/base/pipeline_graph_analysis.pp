class jenkins_plugin::plugins::base::pipeline_graph_analysis {

  jenkins::plugin { 'pipeline-graph-analysis':
    version => '1.10',
  }
}
