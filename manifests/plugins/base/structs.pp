# Manages the Jenkins structs plugin
#
class jenkins_plugin::plugins::base::structs (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'structs':
    version => $version,
  }
}
