# Manages the Jenkins mercurial plugin
#
class jenkins_plugin::plugins::base::mercurial (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'mercurial':
    version => $version,
  }
}
