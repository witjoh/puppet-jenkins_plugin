# @Summary Add/remove a server mappinit to a Global Maven Settings.xml section
#
# NOOT: recommanded title for this defined rource: "${maven_configid}_${serverid}"
#       but we do not enforce it
#
# @param ensure [absent, present] Add or remove a server mapping
#
# @param maven_configid [String] The id if the Global Maven Settings section,
#   containing the server mapping
#
# @param serverid [String] the serverid of the mapping
#
# @param credentialsid [String] The id of the credentials to be used for this server.
#
#
define jenkins_plugin::config::plugins::config_file_provider::global_maven_server_mapping (
  String                    $maven_configid,
  String                    $serverid,
  String                    $credentialsid,
  Enum['present', 'absent'] $ensure = 'present',
) {

  Jenkins::Cli::Exec {
    plugin => 'config-file-provider',
  }

  $mytitle = "${maven_configid}-${serverid}"

  $_maven_configid = "globalmavenconfigid:${maven_configid} "
  $_serverid       = "serverid:${serverid} "
  $_credentialsid  = "credentialsid:${credentialsid} "

  $set_unless_command = 'insync_global_maven_server_mapping'
  $del_unless_command = 'get_global_maven_server_mapping'
  $set_command = 'set_global_maven_server_mapping'
  $del_command = 'del_global_maven_server_mapping'
  $arguments = strip("${_maven_configid}${_serverid}${_credentialsid}")

  if $ensure == 'present' {
    jenkins::cli::exec { "${set_command}-${mytitle}":
      command => "${set_command} ${arguments}",
      unless  => "[[ \$(\$HELPER_CMD ${set_unless_command} ${shellquote($arguments)}) == true ]]",
    }
  } else {
    jenkins::cli::exec { "${del_command}-${mytitle}":
      command => "${del_command} ${arguments}",
      unless  => "[[ -z \$(\$HELPER_CMD ${del_unless_command} ${arguments}) ]]",
    }
  }
}
