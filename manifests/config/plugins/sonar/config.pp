# configures te sonar global configuration
#
define jenkins_plugin::config::plugins::sonar::config (
  Jenkins_plugin::JenkinsUrl $serverurl,
  String                     $credentialsid,
  Enum['present', 'absent']  $ensure                       = 'present',
  String                     $sonarname                    = $title,
  Optional[String]           $mojoversion                  = undef,
  Optional[String]           $additionalanalysisproperties = undef,
  Optional[String]           $additionalproperties         = undef
) {

  Jenkins::Cli::Exec {
    plugin => 'sonar',
  }

  $_name = "name:'${sonarname}' "
  $_credentialsid = "credentialsid:'${credentialsid}' "
  $_serverurl = "serverurl:${serverurl} "
  if $mojoversion {
    $_mojoversion = "mojoversion:${mojoversion} "
  } else {
    $_mojoversion = undef
  }

  if $additionalanalysisproperties {
    $_additionalanalysisproperties = "additionalanalysisproperties:'${additionalanalysisproperties}' "
  } else {
    $_additionalanalysisproperties = undef
  }

  if $additionalproperties {
    $_additionalproperties = "additionalproperties:'${additionalproperties}' "
  } else {
    $_additionalproperties = undef
  }

  $set_unless_command = 'sonar_insync_globalconfig'
  $del_unless_command = 'sonar_get_globalconfig'
  $set_command = 'sonar_set_globalconfig'
  $del_command = 'sonar_del_globalconfig'
  $arguments = strip("${_name}${_credentialsid}${_serverurl}${_mojoversion}${_additionalanalysisproperties}${_additionalproperties}")

  if $ensure == 'present' {
    jenkins::cli::exec { "${set_command}-${title}":
      command => "${set_command} ${arguments}",
      unless  => "[[ \$(\$HELPER_CMD ${set_unless_command} ${shellquote($arguments)}) == true ]]",
    }
  } else {
    jenkins::cli::exec { "${del_command}-${title}":
      command => "${del_command} ${sonarname}",
      unless  => "[[ -z \$(\$HELPER_CMD ${del_unless_command} ${sonarname}) ]]",
    }
  }
}
