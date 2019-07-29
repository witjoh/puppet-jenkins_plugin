class jenkins_plugin::plugins::base::build_blocker_plugin {

  jenkins::plugin { 'build-blocker-plugin':
    version => '1.7.3',
  }
}
