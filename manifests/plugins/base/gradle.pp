# Manages the Jenkins gradle plugin
#
class jenkins_plugin::plugins::base::gradle (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'gradle':
    version => $version,
  }
}
