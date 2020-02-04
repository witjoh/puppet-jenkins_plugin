class jenkins_plugin::plugins::base::handlebars (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'handlebars':
    version => $version,
  }
}
