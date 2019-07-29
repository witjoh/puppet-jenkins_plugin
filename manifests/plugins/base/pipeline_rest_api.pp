class jenkins_plugin::plugins::base::pipeline_rest_api {

  jenkins::plugin { 'pipeline-rest-api':
    version => '2.11',
  }
}
