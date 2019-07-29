class jenkins_plugin::plugins::base::job_dsl {

  jenkins::plugin { 'job-dsl':
    version => '1.74',
  }
}
