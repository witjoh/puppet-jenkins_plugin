class jenkins_plugin::plugins::base::jdk_tool {

  jenkins::plugin { 'jdk-tool':
    version => '1.2',
  }
}
