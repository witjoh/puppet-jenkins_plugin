# Manages the Jenkins workflow-aggregator plugin
#
class jenkins_plugin::plugins::base::workflow_aggregator (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'workflow-aggregator':
    version => $version,
  }
}
