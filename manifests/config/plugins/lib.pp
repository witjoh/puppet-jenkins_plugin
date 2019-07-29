# installs a common method library useable by all groovy scripts
#
# if one wants to use the common methods in there plugin groovy script
# the following groovy code should be added in the groovy script:
#
# ///////////////////////////////////////////////////////////////////////////////
# //  puppet helper library loading (class Util)
# ///////////////////////////////////////////////////////////////////////////////
# 
# def sourceFile = new File('/usr/lib/jenkins/groovy/plugins/lib/Plib.groovy')
# def groovyClass = new GroovyClassLoader(getClass().getClassLoader()).parseClass(sourceFile)
# def plib = groovyClass.newInstance()
#
# // Private methods don't appear to be "private" under groovy.  This utility
# // class is for methods that should not be exposed as CLI options via the
# // Action class.
# class Util {
#   Util(out) { this.out = out }
#   def out
# 
# } // class Util
# 
# // add the common plib methods to the Utils class, as ig they were
# // defined in the Util Class.
# 
# Util.metaClass.mixin plib.getClass()
#
class jenkins_plugin::config::plugins::lib {

  file { '/usr/lib/jenkins/groovy/plugins/lib':
    ensure => directory,
    mode   => '0750',
    owner  => 'jenkins',
    group  => 'jenkins',
  }

  file { '/usr/lib/jenkins/groovy/plugins/lib/Plib.groovy':
    ensure => directory,
    mode   => '0640',
    owner  => 'jenkins',
    group  => 'jenkins',
    source => 'puppet:///modules/jenkins_plugin/groovy/plugins/lib/Plib.groovy',
  }
}
