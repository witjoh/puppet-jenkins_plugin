# Manages the Jenkins workflow-scm-step plugin
#
class jenkins_plugin::plugins::base::workflow_scm_step (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'workflow-scm-step':
    version => $version,
  }
}
