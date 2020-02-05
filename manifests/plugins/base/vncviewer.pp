# Manages the Jenkins vncviewer plugin
#
class jenkins_plugin::plugins::base::vncviewer (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'vncviewer':
    version => $version,
  }
}
