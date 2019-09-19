# @summary Adds a SSH remote Site in the Configure System section
#
# @param hostname [Stdlib::Host] The hostname of the remote server
#
# @param port [Stdlib::Port] The portnumber the remote ssh server is listening on.
#
# @param credentialsid [String] The credentials id used to autenticate on the remote ssh server
#
# @param pty [Boolean] Use PTY channel
#
# @param serveraliveinterval [Integer] The desired serverAliveInterval in milliseconds (0 = off)
#
# @param timeout [Integer] The timeout to wait for a connection in milliseconds (0 = default timeout).
#
define jenkins_plugin::config::plugins::ssh_site (
  String                    $credentialid,
  Stdlib::Host              $hostname = $title,
  Enum['present', 'absent'] $ensure = 'present',
  Stdlib::Port              $port = 22,
  Boolean                   $pty = false,
  Integer                   $serveraliveinterval = 0,
  Integer                   $timeout = 0,
) {

  Jenkins::Cli::Exec {
    plugin => 'ssh',
  }

  $arguments = "hostname:${hostname} port:${port} credentialid:'${credentialid}' pty:${pty} serveraliveinterval:${serveraliveinterval} timeout:${timeout}"

  if $ensure == 'present' {
    jenkins::cli::exec { "set_ssh_remote_host-${title}":
      command => "set_ssh_remote_host ${arguments}",
      unless  => "\$HELPER_CMD insync_ssh_remote_host ${shellquote($arguments)} | /bin/grep '^true$'",
    }

  } else {
    jenkins::cli::exec { "del_ssh_remote_host-${title}":
      command => "del_ssh_remote_host '${hostname}'",
      unless  => "[[ -z \$(\$HELPER_CMD get_ssh_remote_host '${hostname}' | /bin/grep '${hostname}') ]]",
    }
  }
}
