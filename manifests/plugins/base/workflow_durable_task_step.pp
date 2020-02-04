class jenkins_plugin::plugins::base::workflow_durable_task_step (
  Jenkins_plugin::SemVer $version,
) {

  jenkins::plugin { 'workflow-durable-task-step':
    version => $version,
  }
}
