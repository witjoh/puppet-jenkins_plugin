# Manages the Jenkins clone-workspace-scm plugin
# 
class jenkins_plugin::plugins::base::clone_workspace_scm (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'clone-workspace-scm':
    version => $version,
  }
}
