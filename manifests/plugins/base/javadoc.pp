# Manages the Jenkins javadoc plugin
#
class jenkins_plugin::plugins::base::javadoc (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'javadoc':
    version => $version,
  }
}
