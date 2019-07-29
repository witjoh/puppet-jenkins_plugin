# This module configures the core settings in the jenkins
# global security page.  Settings added by a plugin should
# managed by their own class/define
#
# Settings of the parameters are the jenkins defaults
#
class jenkins_plugin::config::master::security (
  Boolean           $csfr_protection          = false,
  Boolean           $cli_remoting             = false,
  Boolean           $agent_master_kill_switch = true,   # reverse logic in jenkins gui
  Optional[Integer] $sshd_port                = undef,
) {

  include jenkins_plugin::config::master::groovy

  Jenkins::Cli::Exec {
    plugin => 'global',
  }
  # false/true maps to on/of in the groovy

  jenkins::cli::exec { "set_crumb_issuer ${bool2str($csfr_protection)}":
    unless => "[ \$(\$HELPER_CMD get_crumb_issuer) = ${bool2str($csfr_protection, 'on', 'off')} ]",
  }

  jenkins::cli::exec { "set_cli_remoting ${bool2str($cli_remoting)}":
    unless => "\$HELPER_CMD get_cli_remoting |/bin/grep -E '${bool2str($cli_remoting, 'on', 'off')}|removed'",
  }

  jenkins::cli::exec { "set_agent_master_kill_switch ${bool2str($agent_master_kill_switch)}":
    unless => "[ \$(\$HELPER_CMD get_agent_master_kill_switch) = ${bool2str($agent_master_kill_switch, 'on', 'off')} ]",
  }

  if $sshd_port {
    $_sshd_port = $sshd_port
  } else {
    $_sshd_port = -1
  }

  jenkins::cli::exec { "set_sshd_port ${_sshd_port}":
    unless => "[ \$(\$HELPER_CMD get_sshd_port) = ${_sshd_port} ]",
  }
}
