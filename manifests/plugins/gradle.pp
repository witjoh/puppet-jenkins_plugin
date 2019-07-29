# manages the jenkins Disk Usage Plugin
#
class jenkins_plugin::plugins::gradle {

  include jenkins_plugin::plugins::base::gradle
  # provided by the upstream module
  # include jenkins_plugin::plugins::base::structs

}
