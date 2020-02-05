# Manages the Jenkins ace-editor plugin
#
class jenkins_plugin::plugins::base::ace_editor (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'ace-editor':
    version => $version,
  }
}
