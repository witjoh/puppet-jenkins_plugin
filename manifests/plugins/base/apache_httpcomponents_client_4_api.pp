class jenkins_plugin::plugins::base::apache_httpcomponents_client_4_api (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'apache-httpcomponents-client-4-api':
    version => $version,
  }
}

