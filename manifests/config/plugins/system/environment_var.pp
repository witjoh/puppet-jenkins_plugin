# Manages global environment variables on the master
#
# @summary Manages Global Properties: Environment variables
#
# @example
#   jenkins_plugin::config::system::environment_var { 'MYENV':
#
#     ensure => present,
#     value  => 'foo',
#   }
#
# @param env_value: content of the environment variable. Must be set
#   when ensure =>present.
#
# @param env_key: The environment variable to be set.
#
# @param ensure Can be either present or absent
#
# @param force_upcase : when set to true. $env_key is converted to upcase.
#
define jenkins_plugn::config::plugins::system::environment_var(
  Optional[String]          $env_value    = undef,
  String                    $env_key      = $title,
  Enum['absent', 'present'] $ensure       = 'present',
  Boolean                   $force_upcase = true,
) {

  Jenkins::Cli::Exec {
    plugin => 'global',
  }

  if $force_upcase {
    $_env_key = upcase($env_key)
  } else {
    $_env_key = $env_key
  }

  if $ensure == 'present' {
    if ! $env_value {
      fail('The attribute $env_value must be set when $ensure => present !')
    }
    jenkins::cli::exec { "set_global_env-${title}":
      command => "set_global_env ${_env_key} ${env_value}",
      unless  => "[[ \$(\$HELPER_CMD get_global_env ${_env_key}) == ${env_value} ]]",
    }
  } else {
    jenkins::cli::exec { "del_global_env-${title}":
      command => "del_global_env ${_env_key}",
      unless  => "[[ -z \$(\$HELPER_CMD get_global_env ${_env_key}) ]]",
    }
  }
}
