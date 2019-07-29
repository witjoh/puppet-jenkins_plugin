# configures a server in the sonar scanner section
#
# @Summary Adds a graphana server for the metrics-graphite config
#
# @param runnername [String] The name of the sonar-scanner installation
#
# @param home [Stdlib::Absolutepath] Maven home directory for this isntallation
#
define jenkins_plugin::config::plugins::sonar::runner (
  Stdlib::Absolutepath      $home,
  Enum['present', 'absent'] $ensure    = 'present',
  String                    $runnername = $title,
) {

  Jenkins::Cli::Exec {
    plugin => 'sonar',
  }

  $_name = "name:${runnername} "
  $_home = "home:${home} "

  $set_unless_command = 'sonar_insync_runner'
  $del_unless_command = 'sonar_get_runner'
  $set_command = 'sonar_set_runner'
  $del_command = 'sonar_del_runner'
  $arguments = strip("${_name}${_home}")

  if $ensure == 'present' {
    jenkins::cli::exec { "${set_command}-${title}":
      command => "${set_command} ${arguments}",
      unless  => "[[ \$(\$HELPER_CMD ${set_unless_command} ${shellquote($arguments)}) == true ]]",
    }
  } else {
    jenkins::cli::exec { "${del_command}-${title}":
      command => "${del_command} ${runnername}",
      unless  => "[[ -z \$(\$HELPER_CMD ${del_unless_command} ${runnername}) ]]",
    }
  }
}
