class jenkins_plugin::plugins::base::build_failure_analyzer {
  jenkins::plugin { 'build-failure-analyzer':
    version => '1.22.0',
  }
}
