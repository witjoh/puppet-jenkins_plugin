# Manages the Jenkins disk-usage plugin
#
class jenkins_plugin::plugins::base::disk_usage (
  Jenkins_plugin::SemVer $version,
) {
  jenkins::plugin { 'disk-usage':
    version => $version,
  }
}
