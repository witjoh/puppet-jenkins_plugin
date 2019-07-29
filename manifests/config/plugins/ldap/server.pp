# define to be used with the ldap plugin.
# this handles server specific configuration, and should be
# used beside the ldap global configuration.
#
# for now we will use plain text passwords in the puppet code
# still looking for a good way to obscure/encrypt those.
#
# the title should be the ldap server URI to connect to in the form of :
#
# this class needs a custom jenkins::cli::config
#
# ldap[s]://your.ldap.server[:ldapport]
#
define jenkins_plugin::config::plugins::ldap::server (
  String                   $managerdn,
  String                   $managerpassword,
  Enum['present','absent'] $ensure                   = 'present',
  Jenkins_plugin::LDAPUrl  $server                   = $title,
  String                   $usersearch               = 'uid={0}',
  Boolean                  $inhibitinferrootdn       = false,
  String                   $displaynameattributename = 'displayname',
  String                   $mailaddressattributename = 'mail',
  Optional[String]         $rootdn                   = undef,
  Optional[String]         $usersearchbase           = undef,
  Optional[String]         $groupsearchbase          = undef,
  Optional[String]         $groupsearchfilter        = undef,
) {

  $_managerdn = "managerdn:${managerdn} "
  $_managerpassword = "managerpassword:'${managerpassword}' "
  $_server = "server:${server} "
  $_usersearch = "usersearch:${usersearch} "
  $_inhibitinferrootdn = "inhibitinferrootdn:${bool2str($inhibitinferrootdn)} "
  $_displaynameattributename = "displaynameattributename:${displaynameattributename} "
  $_mailaddressattributename = "mailaddressattributename:${mailaddressattributename} "

  if $rootdn {
    $_rootdn = "rootdn:${rootdn} "
  } else {
    $_rootdn = ''
  }

  if $usersearchbase {
    $_usersearchbase = "usersearchbase:${usersearchbase} "
  } else {
    $_usersearchbase = ''
  }

  if $groupsearchbase {
    $_groupsearchbase = "groupsearchbase:${groupsearchbase} "
  } else {
    $_groupsearchbase = ''
  }

  if $groupsearchfilter {
    $_groupsearchfilter = "groupsearchfilter:${groupsearchfilter} "
  } else {
    $_groupsearchfilter = ''
  }


  $arguments = strip("${_server}${_managerdn}${_managerpassword}${_usersearch}${_inhibitinferrootdn}${_displaynameattributename}${_mailaddressattributename}${_rootdn}${_usersearchbase}${_groupsearchbase}${_groupsearchfilter}")
  $set_command = 'ldap_set_server'
  $unless_command = 'ldap_insync_server'

  if $ensure == 'present' {
    jenkins::cli::exec { "${set_command}-${title}":
      command => "${set_command} ${$arguments}",
      unless  => "[ \$(\$HELPER_CMD ${unless_command} ${shellquote($arguments)}) = true ]",
      plugin  => 'ldap',
    }
  } else {
    jenkins::cli::exec { "ldap_del_server-${title}":
      command => "ldap_del_server ${server}",
      unless  => "[[ -z \$(\$HELPER_CMD ldap_get_server ${server} | grep ${server}) ]]",
      plugin  => 'ldap',
    }
  }
}
