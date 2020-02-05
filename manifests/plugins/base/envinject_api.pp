# Manages the Jenkins envinject-api plugin
#
class jenkins_plugin::plugins::base::envinject_api (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'envinject-api':
    version => $version,
  }
}
