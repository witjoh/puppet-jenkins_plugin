class jenkins_plugin::plugins::jobdsl {

  include jenkins_plugin::plugins::base::job_dsl
  include jenkins_plugin::plugins::base::script_security
  ## structs is installed by the upstream module
  # include jenkins_plugin::plugins::base::structs

}
