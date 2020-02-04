class jenkins_plugin::plugins::base::windows_slaves (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'windows-slaves':
    version => $version,
  }
}
