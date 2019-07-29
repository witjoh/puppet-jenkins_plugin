# This class manages some fields from the Configure System Screen
#
# See the gui for information
#
class jenkins_plugin::config::master::global (
  Variant[String, Undef]          $labels         = undef,
  Optional[String]                $message        = undef,
  Boolean                         $restrict_usage = false,
  Jenkins_plugin::JenkinsUrl      $root_url       = "http://${facts['fqdn']}:8080",
  Optional[Jenkins_plugin::Email] $admin_mail     = undef,
) {

  include jenkins_plugin::config::master::groovy

  Jenkins::Cli::Exec {
    plugin => 'global',
  }

  jenkins::cli::exec { "set_master_labels ${stringify_undef($labels)}":
    unless => "[ \"\$(\$HELPER_CMD get_master_labels)\" = \"${stringify_undef($labels, 'null')}\" ]",
  }

  jenkins::cli::exec { "set_system_message '${stringify_undef($message)}'":
    unless => "[ \"\$(\$HELPER_CMD get_system_message)\" = \"${stringify_undef($message, 'null')}\" ]",
  }

  jenkins::cli::exec { "set_master_usage ${bool2str($restrict_usage, 'EXCLUSIVE', 'NORMAL')}":
    unless => "[ \$(\$HELPER_CMD get_master_usage) = ${bool2str($restrict_usage, 'EXCLUSIVE', 'NORMAL')} ]",
  }

  # jenkins always adds a '/' at the end of the url

  if $root_url == "${chop($root_url)}/" {
    $_root_url = $root_url
  } else {
    $_root_url = "${root_url}/"
  }

  jenkins::cli::exec { "set_jenkins_url ${root_url}":
    unless => "[ \$(\$HELPER_CMD get_jenkins_url) = ${_root_url} ]",
  }

  jenkins::cli::exec { "set_admin_email '${stringify_undef($admin_mail)}'":
    unless => "[ \"\$(\$HELPER_CMD get_admin_email)\" = \"${stringify_undef($admin_mail, 'null')}\" ]",
  }
}
