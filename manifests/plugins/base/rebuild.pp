# Manages the Jenkins rebuild plugin
#
class jenkins_plugin::plugins::base::rebuild (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'rebuild':
    version => $version,
  }
}
