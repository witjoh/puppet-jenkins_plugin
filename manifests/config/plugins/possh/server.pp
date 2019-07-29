# Configures an ssh host in the publish over ssh plugin
#
# @summary publish over SSH server configuration
#
# @param hostname [Stdlib::Host] SSH hostname or IP address to connect to.
#
# @param username [String] The username to connect with.
#
# @param configname [String] The name of this configuration. Defaults
#   to the $title.
#
# @param remoterootdir [Stdlib::Absolutepath] The base directory for this configuration on
#   the remote system.
#
# @param overridekey [Boolean] Override the default authentication key.
#
# @param encryptedpassword [String] Passphrase/password used to either connect to
#   the remote site, or decrypt the key.
#   to generate a jeninks encrypted password :
#   http://<jenkins.server>:8080/script
#   In the console :
#   hudson.util.Secret.fromString('your pasword').getEncryptedValue()
#
# @param password [String] Plain text Passphrase/password.
#
# @param keypath [String] The path to the private key. Can be absolute, or relative to $JENKINS_HOME
#
# @param key [string] The private key. Whenever a key is given, the keypath will be ignored.
#
# @param jumphost [Stdlib::Host] The jump host is used to tunnel the SSH connection to the target host.
#
# @param port [Stdlib::Port] The port the SSH server is listening on.
#   Default: 22
#
# @param timeout [Integer] Timeout in milliseconds for the SSH connections. Default : 300000
#
# @param disableexec [Boolean] Remove the ability to run Exec commands in this configuration.
#   Default: false
#
# @param proxytype [Jenkins_plugin::proxytype] The type of proxy. Empty value if no proxy.
#   Possible values: HTTP, SOCK4, SOCK5
#
# @param proxyhost [Stdlib::Host] Proxy hostname or IP address to connect to
#
# @param proxyport [Stdlib::Port] The port the Proxy server is listening on.
#
# @param proxyuser [String] The proxy username to connect with.
#
# @param ProxyPassword [String] The proxy password to connect with.
#
define jenkins_plugin::config::plugins::possh::server (
  Stdlib::Host                        $hostname,
  String                              $username,
  Enum['present','absent']            $ensure            = 'present',
  String                              $configname        = $title,       # we could not use name, reserved word
  Optional[Stdlib::Absolutepath]      $remoterootdir     = undef,
  Boolean                             $overridekey       = false,
  Optional[String]                    $encryptedpassword = undef,
  Optional[String]                    $password          = undef,
  Optional[String]                    $keypath           = undef,
  Optional[String]                    $key               = undef,
  Optional[Stdlib::Host]              $jumphost          = undef,
  Optional[Stdlib::Port]              $port              = 22,
  Integer                             $timeout           = 300000,
  Boolean                             $disableexec       = false,
  Optional[Jenkins_plugin::Proxytype] $proxytype         = undef,
  Optional[Stdlib::Host]              $proxyhost         = undef,
  Optional[Stdlib::Port]              $proxyport         = 0,
  Optional[String]                    $proxyuser         = undef,
  Optional[String]                    $proxypassword     = undef,
){

  Jenkins::Cli::Exec {
    plugin => 'publish-over-ssh',
  }

  if $ensure == 'present' {

    if $remoterootdir {
      $_remoterootdir = "remoterootdir:${remoterootdir} "
    } else {
      $_remoterootdir = undef
    }

    if $jumphost {
      $_jumphost = "jumphost:${jumphost} "
    } else {
      $_jumphost = undef
    }

    $host_config = strip("name:'${configname}' hostname:${hostname} username:${username} port:${port} timout:${timeout} disableexec:${disableexec} ${_remoterootdir}${_jumphost}")

    if $overridekey {

      if $encryptedpassword {
        $_encryptedpassword = "encryptedpassword:${encryptedpassword} "
      } else {
        $_encryptedpassword = undef
      }
      if $password {
        $_password = "password:'${password}' "
      } else {
        $_password = undef
      }

      if $key {
        $_key = "key:'${Binary.new($key, '%s')}' " # lint:ignore:variable_scope lint:ignore:variable_is_lowercase
        $_keypath = undef
      } else {
        $_key = undef
        if $keypath {
          $_keypath = "keypath:${keypath} "
        } else {
          $_keypath = undef
        }
      }

      $host_cred = strip("overridekey:${overridekey} ${_encryptedpassword}${_password}${_keypath}${_key}")
    } else {
      $host_cred = undef
    }

    if $proxytype {
      if $proxyhost {
        $_proxyhost = "proxyhost:${proxyhost} "
      } else {
        $_proxyhost = undef
      }

      if $proxyuser {
        $_proxyuser = "proxyuser:'${proxyuser}' "
      } else {
        $_proxyuser = undef
      }

      if $proxypassword {
        $_proxypassword = "proxypassword:'${proxypassword}' "
      } else {
        $_proxypassword = undef
      }

      $proxy_settings = strip("proxytype:${proxytype} proxyport:${proxyport}${_proxyhost}${_proxyuser}${_proxypassword}")
    } else {
      $proxy_settings = undef
    }

    $arguments = strip("${host_config} ${host_cred} ${proxy_settings}")

    jenkins::cli::exec { "possh_set_ssh_server-${title}":
      command => "possh_set_ssh_server ${arguments}",
      unless  => "\$HELPER_CMD possh_insync_ssh_server ${shellquote($arguments)} | /bin/grep '^true$'",
    }

  } else {
    jenkins::cli::exec { "poshh_del_ssh_server-${title}":
      command => "possh_del_ssh_server '${configname}'",
      unless  => "[[ -z \$(\$HELPER_CMD poshh_get_ssh_server '${configname}' | /bin/grep '${configname}') ]]",
    }
  }
}
