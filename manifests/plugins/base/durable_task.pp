class jenkins_plugin::plugins::base::durable_task (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'durable-task':
    version => $version,
  }
}
