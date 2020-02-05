# Manages the Jenkins testInProgress plugin
#
class jenkins_plugin::plugins::base::testinprogress (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'testInProgress':
    version => $version,
  }
}
