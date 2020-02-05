# Manages the Jenkins email-ext plugin
#
class jenkins_plugin::plugins::base::email_ext (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'email-ext':
    version => $version,
  }
}
