# @Summary Adds a graphana server for the metrics-graphite config
#
# @param mavenname [String] The name of the maven installation
#
# @param mavenhome [Stdlib::Absolutepath] Maven home directory for this installation
#
define jenkins_plugin::config::plugins::nodejs::installation (
  Stdlib::Absolutepath      $nodejshome,
  Enum['present', 'absent'] $ensure    = 'present',
  String                    $nodejsname = $title,
) {

  Jenkins::Cli::Exec {
    plugin => 'nodejs',
  }

  $_name = "name:'${nodejsname}' "
  $_home = "home:${nodejshome} "

  $set_unless_command = 'insync_nodejs_installation'
  $del_unless_command = 'get_nodejs_installation'
  $set_command = 'set_nodejs_installation'
  $del_command = 'del_nodejs_installation'
  $arguments = strip("${_name}${_home}")

  if $ensure == 'present' {
    jenkins::cli::exec { "${set_command}-${title}":
      command => "${set_command} ${arguments}",
      unless  => "[[ \$(\$HELPER_CMD ${set_unless_command} ${shellquote($arguments)}) == true ]]",
    }
  } else {
    jenkins::cli::exec { "${del_command}-${title}":
      command => "${del_command} ${arguments}",
      unless  => "[[ -z \$(\$HELPER_CMD ${del_unless_command} ${nodejsname}) ]]",
    }
  }
}
