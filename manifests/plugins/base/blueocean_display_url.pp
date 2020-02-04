class jenkins_plugin::plugins::base::blueocean_display_url (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'blueocean-display-url':
    version => $version,
  }
}

