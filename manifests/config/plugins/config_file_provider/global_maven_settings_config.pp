# @Summary Adds a Global Maven Settings.xml to the config file section
#
# @param ensure [absent, present] Add or remove a global Maven Settings.xml
#
# @param config_id [String] The id if the Global Maven Settings section,
#   to be refered to in the jenkins jobs.
#
# @param config_name [String] Descriptive name of the configuration section
#
# @param content [String] The content of the settings.xml
#
# @param comment [String] A comment
#
define jenkins_plugin::config::plugins::config_file_provider::global_maven_settings_config (
  String                    $config_name,
  String                    $content,
  String                    $comment,
  String                    $config_id      = $title,
  Enum['present', 'absent'] $ensure         = 'present',
  Boolean                   $encode_content = true,
) {

  Jenkins::Cli::Exec {
    plugin => 'config-file-provider',
  }

  $_id      = "id:${config_id} "
  $_name    = "name:'${config_name}' "
  if $encode_content {
    $_content = "content:${base64(encode,$content,strict)} isencoded:true "
  } else {
    $_content = "content:'${content}' isencoded:false "
  }
  $_comment = "comment:'${comment}' "

  $set_unless_command = 'insync_global_maven_settings_config'
  $del_unless_command = 'get_global_maven_settings_config'
  $set_command = 'set_global_maven_settings_config'
  $del_command = 'del_global_maven_settings_config'
  $arguments = strip("${_id}${_name}${_content}${_comment}")

  if $ensure == 'present' {
    jenkins::cli::exec { "${set_command}-${title}":
      command => "${set_command} ${arguments}",
      unless  => "[[ \$(\$HELPER_CMD ${set_unless_command} ${shellquote($arguments)}) == true ]]",
    }
  } else {
    jenkins::cli::exec { "${del_command}-${title}":
      command => "${del_command} id:${config_id}",
      unless  => "[[ -z \$(\$HELPER_CMD ${del_unless_command} ${config_id}) ]]",
    }
  }
}
