class jenkins_plugin::plugins::base::blazemeterjenkinsplugin {

  jenkins::plugin { 'BlazeMeterJenkinsPlugin':
    version => '4.7',
  }
}
