class jenkins_plugin::plugins::base::job_dsl (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'job-dsl':
    version => $version,
  }
}
