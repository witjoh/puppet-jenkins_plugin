# manages the jenkins workspace cleanup Plugin
#
class jenkins_plugin::plugins::workspace_cleanup {

  include jenkins_plugin::plugins::base::ws_cleanup
  include jenkins_plugin::plugins::base::workflow_durable_task_step
  include jenkins_plugin::plugins::base::matrix_project
  include jenkins_plugin::plugins::base::resource_disposer
  include jenkins_plugin::plugins::base::script_security
  # provided by the upstream module
  # include jenkins_plugin::plugins::base::structs

}
