# Manages the Jenkins mailer plugin
#
class jenkins_plugin::plugins::base::mailer (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'mailer':
    version => $version,
  }
}
