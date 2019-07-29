class jenkins_plugin::plugins::base::pipeline_maven {

  jenkins::plugin {'pipeline-maven':
    version => '3.8.0',
  }
}
