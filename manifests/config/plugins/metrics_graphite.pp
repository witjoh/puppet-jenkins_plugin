# configures a server in the metrics graphite server section
#
# @Summary Adds a graphana server for the metrics-graphite config
#
# @param hostname [String] The hostname of the graphote server
#
# @param port [Integer] Portnumber of the graphite service
#   Default: 2003
#
# @param prefix [String] Prefix string
#   Default: undef
#
define jenkins_plugin::config::plugins::metrics_graphite (
  Enum['present', 'absent'] $ensure   = 'present',
  String                    $hostname = $title,
  Integer                   $port     = 2003,
  Optional[String]          $prefix   = undef,
) {

  Jenkins::Cli::Exec {
    plugin => 'metrics-graphite',
  }

  $_hostname = "hostname:${hostname} "
  $_port = "port:${port} "
  if $prefix {
    $_prefix = "prefix:'${prefix}' "
  } else {
    $_prefix = undef
  }

  $set_unless_command = 'graphite_insync_server'
  $del_unless_command = 'graphite_del_server'
  $set_command = 'graphite_set_server'
  $del_command = 'graphite_del_server'
  $arguments = strip("${_hostname}${_port}${_prefix}")

  if $ensure == 'present' {
    jenkins::cli::exec { "${set_command}-${title}":
      command => "${set_command} ${arguments}",
      unless  => "[[ \$(\$HELPER_CMD ${set_unless_command} ${arguments}) == true ]]",
    }
  } else {
    jenkins::cli::exec { "${del_command}-${title}":
      command => "${del_command} ${hostname}",
      unless  => "[[ -z \$(\$HELPER_CMD ${set_unless_command} ${hostname}) ]]",
    }
  }
}
