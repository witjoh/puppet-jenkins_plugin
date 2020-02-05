# Manages the Jenkins git-client plugin
#
class jenkins_plugin::plugins::base::git_client (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'git-client':
    version => $version,
  }
}
