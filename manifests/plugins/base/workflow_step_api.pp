# Manages the Jenkins workflow-step-api plugin
#
class jenkins_plugin::plugins::base::workflow_step_api (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'workflow-step-api':
    version => $version,
  }
}
