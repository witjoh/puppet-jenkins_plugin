class jenkins_plugin::plugins::base::cloudbees_folder (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'cloudbees-folder':
    version => $version,
  }
}
