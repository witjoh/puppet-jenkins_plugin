class jenkins_plugin::plugins::base::blueocean_config (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'blueocean-config':
    version => $version,
  }
}

