class jenkins_plugin::plugins::base::workflow_durable_task_step {

  jenkins::plugin { 'workflow-durable-task-step':
    version => '2.31',
  }
}
