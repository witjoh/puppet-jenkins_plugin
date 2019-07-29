# configures the global ldap configuration
#
class jenkins_plugin::config::plugins::ldap::global (
  Boolean           $disableroleprefixing       = false,
  Boolean           $disablemailaddressresolver = false,
  String            $useridstrategy             = 'CaseInsensitive',
  String            $groupidstrategy            = 'CaseInsensitive',
  Optional[Integer] $cachesize                   = undef,
  Optional[Integer] $cachettl                    = undef,
) {

  Jenkins::Cli::Exec {
    plugin => 'ldap',
  }

  $_disableroleprefixing = "disableroleprefixing:${bool2str($disableroleprefixing)} "
  $_disablemailaddressresolver = "disablemailaddressresolver:${bool2str($disablemailaddressresolver)} "
  $_useridstrategy = "useridstrategy:${useridstrategy} "
  $_groupidstrategy = "groupidstrategy:${groupidstrategy} "

  if $cachesize {
    $_cachesize = "cachesize:${cachesize} "
  } else {
    $_cachesize = ''
  }

  if $cachettl {
    $_cachettl = "cachettl:${cachettl} "
  } else {
    $_cachettl = ''
  }

  $unless_command = 'ldap_insync_settings'
  $set_command = 'ldap_set_settings'
  $arguments = strip("${_disableroleprefixing}${_disablemailaddressresolver}${_useridstrategy}${_groupidstrategy}${_cachesize}${_cachettl}")

  jenkins::cli::exec { 'ldap_set_settings':
    command => "${set_command} ${arguments}",
    unless  => "[[ \$(\$HELPER_CMD ${unless_command} ${shellquote($arguments)}) = true ]]",
  }
}
