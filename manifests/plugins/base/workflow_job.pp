class jenkins_plugin::plugins::base::workflow_job {

  jenkins::plugin { 'workflow-job':
    version => '2.33',
  }
}
