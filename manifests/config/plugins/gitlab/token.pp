# Manages gitlab tokens in the credentials section
#
# Requires the gitlab plugin
#
# @summary Manages gitlab tokens
#
# @example
#   jenkins_plugin::config::plugins::gitlab::token { 'd62e65bd-9d85-4a29-909f-4ef90537ce28':
#     esnure => present,
#     token  => 'jjKidjLSDJksfkssf',
#
# @param token The token generated in Gitlab
#
# @param ensure Can be either present or absent
#
# @param id The token ID to identify this token in Jenkins.  This token
#   is used in other config settings, like the Gitlab connection configuration.
#
# @param description Description of the purpose/usage of the gitlab token
#
define jenkins_plugin::config::plugins::gitlab::token (
  String                    $apitoken,
  String                    $id          = $title,
  Enum['absent', 'present'] $ensure      = 'present',
  String                    $description = 'Api Token for Gitlab',
) {

  Jenkins::Cli::Exec {
    plugin => 'gitlab-plugin',
  }

  if $ensure == 'present' {
    $_apitoken = "apitoken:'${apitoken}' "
    $_id = "id:'${id}' "
    $_description = "description:'${description}' "
    $arguments = strip("${_id}${_apitoken}${_description}")
    $set_command = 'gitlab_set_token'
    $unless_command = 'gitlab_insync_token'

    jenkins::cli::exec { "${set_command}-${title}":
      command => "${set_command} ${arguments}",
      unless  => "[[ \$(\$HELPER_CMD ${unless_command} ${shellquote($arguments)}) == true ]]",
    }
  } else {

    jenkins::cli::exec { "gitlab_del_token-${title}":
      command => "gitlab_del_token '${id}'",
      unless  => "[[ -z \$(\$HELPER_CMD gitlab_get_token '${id}' | /bin/awk '{ print \$1}') ]]",
    }
  }
}
