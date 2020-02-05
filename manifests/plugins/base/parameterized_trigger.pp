# Manages the Jenkins parameterized-trigger plugin
#
class jenkins_plugin::plugins::base::parameterized_trigger (
    Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'parameterized-trigger':
    version => $version,
  }
}
