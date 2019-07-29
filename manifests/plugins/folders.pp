# Installs the folders plugin and related files
#
class jenkins_plugin::plugins::folders {

  jenkins_plugin::plugins::install_groovy { 'cloudbees-folder': }
  include jenkins_plugin::plugins::base::cloudbees_folder
}
