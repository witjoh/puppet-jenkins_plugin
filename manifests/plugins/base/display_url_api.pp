# Manages the Jenkins display-url-api plugin
#
class jenkins_plugin::plugins::base::display_url_api (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'display-url-api':
    version => $version,
  }
}
