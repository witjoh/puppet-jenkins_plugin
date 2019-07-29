# configures the monitor settings for jenkins nodes
#
# @Summary configures the monitor settings for jenkins nodes
#
# @param architecture [Boolean] Monitor the node architercture.
#    Default: true
#
# @param clock [Boolean] Monitors the clock difference between the master and nodes. 
#   Default: true
#
# @param diskspace [Boolean] Monitors the available disk space of $JENKINS_HOME on each agent.
#   Default: true
#
# @param diskspacethreshold [String] This option configures the amount of minimum amount of free disk space
#   desired for an agent's proper operation, such as "1.5GB", "100KB", etc. 
#   Default: '1G'
#
# @param swapspace [Boolean] This monitors the available swap space.
#   Default: true
#
# @param tempspace: [Boolean] This monitors the available disk space of the temporary directory.
#   Defualt: true
#
# @param tempspacethreshold [String] This option configures the amount of minimum amount of free disk space on /tmp
#   desired for an agent's proper operation, such as "1.5GB", "100KB", etc.
#   Default: '1GB'
#
# @param responsetime [Boolean] This monitors the round trip network response time from the master to the agent.
#   Default: true
#
class jenkins_plugin::config::plugins::nodemonitors (
  Boolean $architecture       = true,
  Boolean $clock              = true,
  Boolean $diskspace          = true,
  String  $diskspacethreshold = '1GB',
  Boolean $swapspace          = true,
  Boolean $tempspace          = true,
  String  $tempspacethreshold = '1GB',
  Boolean $responsetime       = true,
) {

  jenkins_plugin::plugins::install_groovy { 'nodemonitors': }

  Jenkins::Cli::Exec {
    plugin => 'nodemonitors',
  }

  $unless_command = 'insync_monitors'
  $set_command = 'set_monitors'
  $argument1 = "architecture:${bool2str($architecture)} clock:${bool2str($clock)} diskspace:${bool2str($diskspace)}"
  $argument2 = "diskspacethreshold:${diskspacethreshold} swapspace:${bool2str($swapspace)} tempspace:${bool2str($tempspace)}"
  $argument3 = "tempspacethreshold:${tempspacethreshold} responsetime:${bool2str($responsetime)}"
  $arguments = "${argument1} ${argument2} ${argument3}"
  jenkins::cli::exec { 'set_monitors':
    command => "${set_command} ${arguments}",
    unless  => "[[ \$(\$HELPER_CMD ${unless_command} ${shellquote($arguments)}) == true ]]",
  }
}
