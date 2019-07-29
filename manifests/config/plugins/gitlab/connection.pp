# Configs a gitlab connection in the Configure Jekins Section
#
# Needs the 'gitlab-plugin' to be installed on the Jenkins Master
#
# @summary Manage a gitlab conenction in Jenkins
#
# @example Example usage
#   jenkins_plugin::config::plugins::gitlab::connection { 'my_gitlab_connection':
#     ensure      => present,
#     gitlab_host => 'http://gitlab.example.com',
#     aptTokenId  => 'My_gitlab_token_id',
#   }
#
# @param ensure Create are remove the gitlab conenction settings form jenkins.
#   Possible values : 'present' or 'absent'.
#   Default: present
#
# @param connection_name The name of the connection.  This name can is used in
#   Jenkins to assign this connection to eg, a job.
#   Default: Resource title
#
# @param gitlab_host The gitlab URL, http or https.
#
# @param api_token_id The id of the apiToken created withe the defined resource
#   jenkins_plugin::config::plugins::gitlab::token.
#   A dependencie to the token resources is created.
#
# @param api_level
#  Gitlab api level to be used. Can be either v3, v4 or autodetect.
#  Default: 'autodetect'
#
# @param connections_timeout The connection timeout for the gitlab connection.
#   Default: 10
#
# @param read_timeout Read timeout for the gitlab connection.
#   Default: 10
#
define jenkins_plugin::config::plugins::gitlab::connection (
  Stdlib::Httpurl                          $url,
  String                                   $apitokenid,
  Enum['present', 'absent']                $ensure            = 'present',
  String                                   $connectionname    = $title,
  Optional[Enum['autodetect', 'v4', 'v3']] $clientbuilderid   = 'autodetect',
  Optional[Integer]                        $connectiontimeout = undef,
  Optional[Integer]                        $readtimeout       = undef,
) {

  Jenkins::Cli::Exec {
    plugin => 'gitlab-plugin',
  }

  if $ensure == 'present' {
    $_url = "url:${url} "
    $_apitokenid = "apitokenid:'${apitokenid}' "
    $_name = "name:'${connectionname}' "
    $_clientbuilderid = "clientbuilderid:${clientbuilderid} "

    if $connectiontimeout {
      $_connectiontimeout = "connectiontimout:${connectiontimeout} "
    } else {
      $_connectiontimeout = ''
    }
    if $readtimeout {
      $_readtimeout = "readtimeout:${readtimeout} "
    } else {
      $_readtimeout = ''
    }

    $unless_command = 'gitlab_insync_connection'
    $set_command = 'gitlab_set_connection'
    $arguments = strip("${_name}${_apitokenid}${_url}${_clientbuilderid}${_connectiontimeout}${_readtimeout}")

    jenkins::cli::exec { "${set_command}-${title}":
      command => "${set_command} ${arguments}",
      unless  => "[ \$(\$HELPER_CMD ${unless_command} ${arguments}) = true ]",
    }
  } else {
    jenkins::cli::exec { "gitlab_del_connection-${title}":
      command => "gitlab_del_connection '${connectionname}'",
      unless  => "[[ -z \$(\$HELPER_CMD gitlab_get_connection '${connectionname}' | /bin/awk '{ print \$1}') ]]",
    }
  }
}
