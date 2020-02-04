class jenkins_plugin::plugins::throttle_concurrents {

  include jenkins_plugin::plugins::base::throttle_concurrents
  include jenkins_plugin::plugins::base::workflow_api
  include jenkins_plugin::plugins::base::workflow_durable_task_step
  include jenkins_plugin::plugins::base::durable_task
  include jenkins_plugin::plugins::base::workflow_step_api
  include jenkins_plugin::plugins::base::workflow_support
  include jenkins_plugin::plugins::base::matrix_project

}
