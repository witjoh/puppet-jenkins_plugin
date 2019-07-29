# class jenkins_plugin::config::plugins::possh::common
#
# Configure the private key for connecting to SSH servers.
# The key configured here is a default key which can be overridden for an individual host.
# this can be done in the defined type jenkins_plugin::config::plugins::possh::server
# The key is specified by pasting into the Key section, or by providing the file path to
# the key in the Path to key. If both are provided, then the Key path will be ignored.
# If Passphrase is provided then it will be used to decrypt the private key.
#
# @summary configures the global publish over ssh section
#
# @param encryptedpassphrase [String] The passphrase for the private key. Leave blank if the key is not encrypted.
#   Following is not working - we just pass the passphrase and ignore the encrypted one.
#   to generate a jeninks encrypted password :
#   http://<jenkins.server>:8080/script
#   In the console :
#   hudson.util.Secret.fromString('your pasword').getEncryptedValue()
#
# @param Passphrase [String] plaint text passphrase
#
# @param keypath [String] The path to the private key. Can be absolute, or relative to $JENKINS_HOME
#
# @param key [string] The private key. Whenever a key is given, the keypath will be ignored.
#
# disableallexec [Boolean] Remove the ability to run Exec commands in this configuration.
#   Default: false
#
class jenkins_plugin::config::plugins::possh::common (
  Optional[String] $encryptedpassphrase = undef,
  Optional[String] $passphrase          = undef,
  Optional[String] $keypath             = undef,
  Optional[String] $key                 = undef,
  Boolean          $disableallexec      = false
) {

  Jenkins::Cli::Exec {
    plugin => 'publish-over-ssh',
  }
  # just to get some cleaner argument string, add always a spece to the vars
  if $encryptedpassphrase {
    $_encryptedpassphrase = "encryptedpassphrase:${encryptedpassphrase} "
  } else {
    $_encryptedpassphrase = undef
  }

  if $passphrase {
    $_passphrase = "passphrase:'${passphrase} '"
  } else {
    $_passphrase = undef
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

  $arguments = strip("${_encryptedpassphrase}${_passphrase}${_key}${_keypath}disableallexec:${disableallexec}")

  jenkins::cli::exec { 'possh_set_common_config':
    command => "possh_set_common_config ${arguments}",
    unless  => "[[ \$(\$HELPER_CMD possh_insync_common_config ${arguments}) == true ]]",
  }
}
