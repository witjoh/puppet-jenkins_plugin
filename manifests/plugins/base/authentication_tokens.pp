# Manages the Jenkins authentication-tokens plugin
#
class jenkins_plugin::plugins::base::authentication_tokens (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'authentication-tokens':
    version => $version,
  }
}
