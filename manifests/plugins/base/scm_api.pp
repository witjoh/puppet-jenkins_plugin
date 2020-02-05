# Manages the Jenkins scm-api plugin
#
class jenkins_plugin::plugins::base::scm_api (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'scm-api':
    version => $version,
  }
}
