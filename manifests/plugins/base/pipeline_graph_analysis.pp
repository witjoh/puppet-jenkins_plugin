class jenkins_plugin::plugins::base::pipeline_graph_analysis (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'pipeline-graph-analysis':
    version => $version,
  }
}
