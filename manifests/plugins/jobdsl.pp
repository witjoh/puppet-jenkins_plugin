# Manages the Jenkins jobdsl plugin and dependencies
#
class jenkins_plugin::plugins::jobdsl {

  include jenkins_plugin::plugins::base::job_dsl
  include jenkins_plugin::plugins::base::script_security
  include jenkins_plugin::plugins::base::structs

}
