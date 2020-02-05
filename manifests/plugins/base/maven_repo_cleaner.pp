# Manages the Jenkins maven-repo-cleaner plugin
#
class jenkins_plugin::plugins::base::maven_repo_cleaner (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'maven-repo-cleaner':
    version => $version,
  }
}
