# Manages the Jenkins matrix-project plugin
#
class jenkins_plugin::plugins::base::matrix_project (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'matrix-project':
    version => $version,
  }
}
