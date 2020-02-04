class jenkins_plugin::plugins::base::blueocean_rest_impl (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'blueocean-rest-impl':
    version => $version,
  }
}

