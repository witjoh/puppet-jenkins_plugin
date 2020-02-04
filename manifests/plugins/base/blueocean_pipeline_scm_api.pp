class jenkins_plugin::plugins::base::blueocean_pipeline_scm_api (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'blueocean-pipeline-scm-api':
    version => $version,
  }
}

