class jenkins_plugin::plugins::base::jenkins_design_language (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'jenkins-design-language':
    version => $version,
  }
}

