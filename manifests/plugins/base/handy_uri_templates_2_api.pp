class jenkins_plugin::plugins::base::handy_uri_templates_2_api (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'handy-uri-templates-2-api':
    version => $version,
  }
}
