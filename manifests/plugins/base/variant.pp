# Manages the Jenkins variant plugin
#
class jenkins_plugin::plugins::base::variant (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'variant':
    version => $version,
  }
}
