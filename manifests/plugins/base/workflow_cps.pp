# Manages the Jenkins workflow-cps plugin
#
class jenkins_plugin::plugins::base::workflow_cps (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'workflow-cps':
    version => $version,
  }
}
