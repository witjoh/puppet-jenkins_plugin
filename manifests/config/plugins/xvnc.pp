# configures the xvnc plugin
#
# @Summary Set the xnvc cponfiguration in the Configure System Section
#
# @param commandlinei [String] The Xvnc command line to invoke.
#
# @param mindisplaynumber [Integer] Minimum X display number to use when starting Xvnc.
#   Default: 10
#
# @param maxdisplaynumber [Integer] Maximum X display number to use when starting Xvnc.
#   Default: 99
#
# @param cleanup: [Boolean] Try to clean up any stale locks or processes before running Xvn.
#   Defualt: false
#
class jenkins_plugin::config::plugins::xvnc (
  Optional[String]  $commandline      = undef,
  Optional[Integer] $mindisplaynumber = undef,
  Optional[Integer] $maxdisplaynumber = undef,
  Optional[Boolean] $cleanup          = undef,
  Optional[Boolean] $skiponwindows    = undef,
) {

  Jenkins::Cli::Exec {
    plugin => 'xvnc',
  }

  # $commandline probably wil have options included starting with a dash
  # thsi makes the exec => unless see those options as java options, 
  # resulting in spawning a bash error :
  # unless: ERROR: "-localhost" is not a valid option
  # Solution : shellquote() function for the arguments in the unless statement

  if  $commandline {
    $_commandline = "commandline:'${commandline}' "
  } else {
    $_commandline = undef
  }

  if $mindisplaynumber {
    $_mindisplaynumber = "mindisplaynumber:${mindisplaynumber} "
  } else {
    $_mindisplaynumber = undef
  }

  if $maxdisplaynumber {
    $_maxdisplaynumber = "maxdisplaynumber:${maxdisplaynumber} "
  } else {
    $_maxdisplaynumber = undef
  }

  if $cleanup {
    $_cleanup = "cleanup:${cleanup} "
  } else {
    $_cleanup = undef
  }

  if $skiponwindows {
    $_skiponwindows = "skiponwindows:${skiponwindows} "
  } else {
    $_skiponwindows = undef
  }

  $unless_command = 'insync_xvnc'
  $set_command = 'set_xvnc'
  $arguments = strip("${_commandline}${_mindisplaynumber}${_maxdisplaynumber}${_cleanup}${_skiponwindows}")

  jenkins::cli::exec { 'set_xvnc':
    command => "${set_command} ${arguments}",
    unless  => "[[ \$(\$HELPER_CMD ${unless_command} ${shellquote($arguments)}) == true ]]",
  }
}
