# Manages the Jenkins naginator plugin
#
class jenkins_plugin::plugins::base::naginator (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'naginator':
    version => $version,
  }
}
