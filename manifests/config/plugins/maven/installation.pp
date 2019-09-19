# @Summary Adds a graphana server for the metrics-graphite config
#
# @param mavenname [String] The name of the maven installation
#
# @param mavenhome [Stdlib::Absolutepath] Maven home directory for this isntallation
#
define jenkins_plugin::config::plugins::maven::installation (
  Stdlib::Absolutepath      $mavenhome,
  Enum['present', 'absent'] $ensure    = 'present',
  String                    $mavenname = $title,
) {

  Jenkins::Cli::Exec {
    plugin => 'maven-plugin',
  }

  ensure_resource('jenkins_plugin::plugins::install_groovy', 'maven-plugin')

  $_name = "name:'${mavenname}' "
  $_mavenhome = "mavenhome:${mavenhome} "

  $set_unless_command = 'maven_insync_installation'
  $del_unless_command = 'maven_get_installation'
  $set_command = 'maven_set_installation'
  $del_command = 'maven_del_installation'
  $arguments = strip("${_name}${_mavenhome}")

  if $ensure == 'present' {
    jenkins::cli::exec { "${set_command}-${title}":
      command => "${set_command} ${arguments}",
      unless  => "[[ \$(\$HELPER_CMD ${set_unless_command} ${shellquote($arguments)}) == true ]]",
    }
  } else {
    jenkins::cli::exec { "${del_command}-${title}":
      command => "${del_command} ${mavenname}",
      unless  => "[[ -z \$(\$HELPER_CMD ${del_unless_command} ${mavenname}) ]]",
    }
  }
}
