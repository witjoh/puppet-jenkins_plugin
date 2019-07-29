class jenkins_plugin::plugins::base::conditional_buildstep {

  jenkins::plugin { 'conditional-buildstep':
    version => '1.3.6',
  }
}
