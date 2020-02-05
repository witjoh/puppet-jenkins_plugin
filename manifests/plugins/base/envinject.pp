# Manages the Jenkins envinject plugin
#
class jenkins_plugin::plugins::base::envinject (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'envinject':
    version => $version,
  }
}
