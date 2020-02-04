class jenkins_plugin::plugins::base::pipeline_maven (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin {'pipeline-maven':
    version => $version,
  }
}
