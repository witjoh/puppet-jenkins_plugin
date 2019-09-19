# @summary Sets the global properties for xvnc in the configure system section  
#
# Requires the xvnc plugin
#
# @example
#   jenkins_plugin::config::plugins::system::xvnc {
#     disable => true,
#   }
#
# @param disbale [Boolean] Disable Xvnc execution on node in Global Properties
#
class jenkins_plugin::config::plugins::system::xvnc (
  Boolean $disable = false,
) {

  Jenkins::Cli::Exec {
    plugin => 'xvnc',
  }

  jenkins::cli::exec { 'set_xvnc_global_properties':
    command => "set_xvnc_global_properties ${disable}",
    unless  => "\$HELPER_CMD get_xvnc_global_properties | /bin/grep ${disable}",
  }
}
