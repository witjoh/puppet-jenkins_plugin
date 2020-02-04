class jenkins_plugin::plugins::base::blueocean_core_js (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'blueocean-core-js':
    version => $version,
  }
}

