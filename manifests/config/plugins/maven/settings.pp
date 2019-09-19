# @Summary Maven Project Configuration
#
# @param  globalmavenopts [String] JVM options needed when launching Maven as an external process.
#   Default: undef
#
# @param localmavenrepository ['default', 'perjob', 'perexecutor'] Default setting of the local
#   repository location when jobs do not specify one.
#   Default: default
#
class jenkins_plugin::config::plugins::maven::settings (
  Optional[String]                         $globalmavenopts      = undef,
  Enum['default', 'perjob', 'perexecutor'] $localmavenrepository = 'default',
) {

  Jenkins::Cli::Exec {
    plugin => 'maven-plugin',
  }

  ensure_resource('jenkins_plugin::plugins::install_groovy', 'maven-plugin')

  if $globalmavenopts {
    $_globalmavenopts = "globalmavenopts:'${globalmavenopts}' "
  } else {
    $_globalmavenopts = undef
  }

  $_localmavenrepository = "localmavenrepository:${localmavenrepository} "

  $set_unless_command = 'insync_global_maven_settings'
  $set_command = 'set_global_maven_settings'
  $arguments = strip("${_globalmavenopts}${_localmavenrepository}")

  jenkins::cli::exec { $set_command:
    command => "${set_command} ${arguments}",
    unless  => "[[ \$(\$HELPER_CMD ${set_unless_command} ${shellquote($arguments)}) == true ]]",
  }
}
