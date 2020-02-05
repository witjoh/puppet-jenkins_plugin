# Manages the Jenkins pam-auth plugin
#
class jenkins_plugin::plugins::base::pam_auth (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'pam-auth':
    version => $version,
  }
}
