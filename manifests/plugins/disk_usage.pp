# manages the jenkins Disk Usage Plugin
#
class jenkins_plugin::plugins::disk_usage {

  include jenkins_plugin::plugins::base::mailer
  include jenkins_plugin::plugins::base::disk_usage

}
