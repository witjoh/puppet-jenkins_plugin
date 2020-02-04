class jenkins_plugin::plugins::base::command_launcher (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'command-launcher':
    version => $version,
  }
}
