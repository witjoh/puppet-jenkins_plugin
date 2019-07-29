class jenkins_plugin::plugins::base::throttle_concurrents {

  jenkins::plugin { 'throttle-concurrents':
    version => '2.0.1',
  }
}
