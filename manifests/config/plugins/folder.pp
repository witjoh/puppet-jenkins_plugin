# Manages folders  
#
# Requires the cloudbees-folders plugin
#
# @summary Manages folders
#
# @example
#   jenkins_plugin::config::plugins::folder { 'myfolder':
#     ensure => present,
#   }
#
# When creating subfolders, the parent folder tree must exists.
# There are no automatic relations between parent- sub folders.
# these must be explicitly set by the user.
#
# @param ensure Can be either present or absent
#
# @param force_remove : when set to absent, if true, remoe folder and all
#   the items within.
#   Default: false
#
#
define jenkins_plugin::config::plugins::folder (
  String                    $folder       = $title,
  Enum['absent', 'present'] $ensure       = 'present',
  Boolean                   $force_remove = false,
) {

  Jenkins::Cli::Exec {
    plugin => 'cloudbees-folder',
  }

  if $ensure == 'present' {
    jenkins::cli::exec { "setFolder-${title}":
      command => "setFolder ${folder}",
      unless  => "\$HELPER_CMD getFolder ${folder} | /bin/grep ${folder}",
    }
  } else {
    jenkins::cli::exec { "removeFolder-${title}":
      command => "removeFolder ${folder} ${bool2str($force_remove)}",
      unless  => "[[ -z \$(\$HELPER_CMD getFolder ${folder} | /bin/grep ${folder}) ]]",
    }
  }
}
