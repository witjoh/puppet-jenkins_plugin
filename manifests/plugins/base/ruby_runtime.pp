# Manages the Jenkins ruby-runtime plugin
#
class jenkins_plugin::plugins::base::ruby_runtime (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'ruby-runtime':
    version => $version,
  }
}
