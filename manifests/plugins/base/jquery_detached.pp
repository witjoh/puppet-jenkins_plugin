class jenkins_plugin::plugins::base::jquery_detached (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'jquery-detached':
    version => $version,
  }
}
