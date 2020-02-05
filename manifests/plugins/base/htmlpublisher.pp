# Manages the Jenkins htmlpublisher plugin
#
class jenkins_plugin::plugins::base::htmlpublisher (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'htmlpublisher':
    version => $version,
  }
}
