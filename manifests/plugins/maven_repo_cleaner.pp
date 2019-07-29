# installs the maven repo cleaner plugin and dependencies
#
class jenkins_plugin::plugins::maven_repo_cleaner {

  include jenkins_plugin::plugins::base::javadoc
  include jenkins_plugin::plugins::base::maven_plugin
  include jenkins_plugin::plugins::base::maven_repo_cleaner

}
