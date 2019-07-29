# A define that isntalls an optional plugin specific
# puppet_helper_<plugin>.groovy file in the correct path
# on the master
#
# @summary plugin groovy script installer
#
# @title: The name of the plugin as used in Jenkins
#
# @param ensure Can be one of File, Present or Absent
#   Default: file
# @param source : the puppet uri of the groovy file.
#   Default : puppet:///modules/jenkins_plugin/groovy/plugins/puppet_helper_<PLUGIN_NAME>.groovy
#
define jenkins_plugin::plugins::install_groovy (
  Enum['file', 'present', 'absent'] $ensure = 'file',
  String                            $source = "puppet:///modules/jenkins_plugin/groovy/plugins/${title}/puppet_helper_${title}.groovy",
) {

  # make sure the common plib groovy file is in place
  include jenkins_plugin::config::plugins::lib

  $libdir = '/usr/lib/jenkins'

  File {
    owner => 'jenkins',
    group => 'jenkins',
    mode  => '0640',
  }

  $parents = {
    "${libdir}/groovy"         => {},
    "${libdir}/groovy/plugins" => {},
  }

  ensure_resources('file', $parents, { ensure =>  'directory' })

  file { "${libdir}/groovy/plugins/${title}":
    ensure => directory,
  }

  case $ensure {
    'file','present': {
      $_ensure = 'file'
    }
    default: {
      $_ensure = 'absent'
    }
  }

  file { "${libdir}/groovy/plugins/${title}/puppet_helper_${title}.groovy":
    ensure => $_ensure,
    source => $source,
  }
}
