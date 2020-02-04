class jenkins_plugin::plugins::base::blueocean_i18n (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'blueocean-i18n':
    version => $version,
  }
}
