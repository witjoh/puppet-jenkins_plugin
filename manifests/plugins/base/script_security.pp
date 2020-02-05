# Manages the Jenkins script-security plugin
#
class jenkins_plugin::plugins::base::script_security (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'script-security':
    version => $version,
  }
}
