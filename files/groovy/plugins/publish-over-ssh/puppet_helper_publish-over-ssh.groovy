// Copyright 2010 VMware, Inc.
// Copyright 2011 Fletcher Nichol
// Copyright 2013-2014 Chef Software, Inc.
// Copyright 2014 RetailMeNot, Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import groovy.transform.InheritConstructors
import org.codehaus.groovy.runtime.InvokerHelper
import hudson.*
import hudson.model.*
import jenkins.*
import jenkins.model.*
import hudson.util.*
import jenkins.plugins.publish_over_ssh.*

///////////////////////////////////////////////////////////////////////////////
//  puppet helper library loading (class Util)
///////////////////////////////////////////////////////////////////////////////
def sourceFile = new File('/usr/lib/jenkins/groovy/plugins/lib/Plib.groovy')
def groovyClass = new GroovyClassLoader(getClass().getClassLoader()).parseClass(sourceFile)
def plib = groovyClass.newInstance()

///////////////////////////////////////////////////////////////////////////////
// Util
///////////////////////////////////////////////////////////////////////////////

// Private methods don't appear to be "private" under groovy.  This utility
// class is for methods that should not be exposed as CLI options via the
// Action class.
class Util {
  Util(out) { this.out = out }
  def out

} // class Util

// add the common Plib methods to the Utils class, as if they were
// defined in the Util Class.

Util.metaClass.mixin plib.getClass()

///////////////////////////////////////////////////////////////////////////////
// Actions
///////////////////////////////////////////////////////////////////////////////

class Actions {
  Actions(out, bindings) {
    this.out = out
    this.bindings = bindings
    this.util = new Util(out)
  }
  def out
  def bindings
  def util

  /////////////////////
  // possh common configuration actions
  /////////////////////

  void possh_get_common_config() {
    util.requirePlugin('publish-over-ssh')

    def j = Jenkins.get()
    def desc = j.getDescriptor("jenkins.plugins.publish_over_ssh.BapSshPublisherPlugin")
    if (desc) {
      def conf = desc.getCommonConfig()
      def map =  [:]
      if (conf) {
        map << [ passphrase: conf.getPassphrase() ]
        map << [ encryptedpassphrase: conf.getEncryptedPassphrase() ]
        map << [ keypath: conf.getKeyPath() ]
        map << [ key: encodeKey(conf.getKey()) ]
        map << [ disableallexec: conf.isDisableAllExec() ]
        map = util.mapRemoveAllNull(map)
        if ( ! map.containsKey('passphrase') ) {
          map.remove('encryptedpassphrase')
        }
        out.println(map.toMapString()?.replaceAll(/, /,/ /))
      }
    }
  }

  void possh_set_common_config ( String... arguments = null )
  { 
    util.requirePlugin('publish-over-ssh')
    def map = util.argsToMap(arguments)
    def encPass = null

    if (map.encryptedpassphrase) {
      encPass = map.encryptedpassphrase
    } else if ( map.passphrase ) {
      encPass = new Secret(map.passphrase).getEncryptedValue()
    }
 
    def j = Jenkins.get() 
    def desc = j.getDescriptor("jenkins.plugins.publish_over_ssh.BapSshPublisherPlugin")
    def conf = new jenkins.plugins.publish_over_ssh.BapSshCommonConfiguration(
      encPass,
      util.decodeKey(map.key),
      map.keypath,
      map.disableallexec?.toBoolean() ?: false
    )

    desc.setCommonConfig(conf)
    desc.save()
  }

  void possh_insync_common_config ( String... arguments = null )
  { 
    util.requirePlugin('publish-over-ssh')
    def mapShould = util.argsToMap(arguments)
    if ( mapShould.key ) {
      mapShould.key = util.decodeKey(mapShould.key)
    }
    def mapIs = [:]

    // add the defaults
    if ( mapShould.containsKey('disableallexec') ) {
      mapShould.disableallexec = mapShould.disableallexec.toBoolean()
    } else { 
      mapShould << [disableallexec: false]
    }

    if ( mapShould.encryptedpassphrase && !mapShould.passphrase ) {
      def temp = new jenkins.plugins.publish_over_ssh.BapSshCommonConfiguration(
        mapShould.encryptedpassphrase,
        null,
        null,
        false )
      mapShould << [ passphrase: temp.getPassphrase() ]
      mapShould.remove('encryptedpassphrase')
    } 

    def j = Jenkins.get() 
    def desc = j.getDescriptor("jenkins.plugins.publish_over_ssh.BapSshPublisherPlugin")
    def conf = desc.getCommonConfig()

    if ( conf ) {
      mapIs << [ keypath: conf.getKeyPath() ]
      mapIs << [ key: conf.getKey() ]
      mapIs << [ disableallexec: conf.isDisableAllExec() ]
      mapIs << [ passphrase: conf.getPassphrase() ]
      mapIs = util.mapRemoveAllNull(mapIs)
    }
      out.println(mapShould.equals(mapIs))
  }

  /////////////////////////
  // possh host server configurations
  ////////////////////////

  LinkedHashMap posshHostToMap(BapSshHostConfiguration host) {
    def map = [:]
    if (host) {
      map << [ name: host.getName() ]
      map << [ hostname: host.getHostname() ]
      map << [ username: host.getUsername() ]
      map << [ remoterootdir: host.getRemoteRootDir() ]
      map << [ overridekey: host.isOverrideKey() ]

      if ( host.isOverrideKey() ) {
        map << [ encryptedpassword: host.getEncryptedPassword() ]
        // we force use of encrypted passwords only
        // map << [ password: host.getPassword() ]
        map << [ keypath: host.getKeyPath() ]
        map << [ key: host.getKey() ]
      }

      map << [ jumphost: host.getJumpHost() ]
      map << [ port: host.getPort() ]
      map << [ timeout: host.getTimeout() ]
      map << [ disableexec: host.isDisableExec() ]

      if ( host.getProxyType() ) {
        map << [ proxytype: host.getProxyType() ]
        map << [ proxyhost: host.getProxyHost() ]
        map << [ proxyport: host.getProxyPort() ]
        map << [ proxyuser: host.getProxyUser() ]
        map << [ proxypassword: host.getProxyPassword() ]
      }

      map = util.mapRemoveAllNull(map)
    }

    return map
  }

  BapSshHostConfiguration mapToPosshHost(LinkedHashMap map) {
    if ( map.name ) { 
      def host = new BapSshHostConfiguration()
      host.setName(map.name)
      host.setHostname(map.hostname)
      host.setUsername(map.username)
      host.setRemoteRootDir(map.remoterootdir)
      host.setPort(map.port ? map.port.toInteger() : 22)
      host.setTimeout(map.timeout ? map.timeout.toInteger() : 300000)
      host.setJumpHost(map.jumphost)
      if ( map.disableexec ) {
        host.setDisableExec(map.disableexec.toBoolean())
      }
      if ( map.overridekey ) {
        host.setOverrideKey(map.overridekey.toBoolean())
        host.setEncryptedPassword(map.encryptedpassword)
        host.setKeyPath(map.keypath)
        host.setKey(map.key)
      }
      if ( map.proxytype ) {
        host.setProxyType(map.proxytype)
        host.setProxyHost(map.proxyhost)
        host.setProxyPort(map.proxyport ? map.proxyport.toInteger() : 0)
        host.setProxyUser(map.proxyuser)
        host.getProxyPassword(map.proxypassword)
      }
      return host 
    } else {
      return null
    }
  }

  void possh_get_all_ssh_servers() {
    util.requirePlugin('publish-over-ssh')

    def j = Jenkins.get()
    def desc = j.getDescriptor("jenkins.plugins.publish_over_ssh.BapSshPublisherPlugin")

    def list = desc.getHostConfigurations()
    if ( ! list.empty ) {
      list.each {
        // TODO encode key ?
        out.println(posshHostToMap(it).toMapString()?.replaceAll(/, /,/ /))
      }
    }
  }

  void possh_get_ssh_server(String name) {

    util.requirePlugin('publish-over-ssh')

    def j = Jenkins.get()
    def desc = j.getDescriptor("jenkins.plugins.publish_over_ssh.BapSshPublisherPlugin")

    def host = desc.getConfiguration(name)
    // TODO encodeKey ???
    out.println(posshHostToMap(host).toMapString()?.replaceAll(/, /,/ /))
  }

  void possh_set_ssh_server(String... arguments) {

    util.requirePlugin('publish-over-ssh')
    def map = util.argsToMap(arguments)

    if (map.key) {
      map.key = util.decodeKey(map.key)
    }

    def srv = mapToPosshHost(map)

    def j = Jenkins.get()
    def desc = j.getDescriptor("jenkins.plugins.publish_over_ssh.BapSshPublisherPlugin")
    
    def host = desc.getConfiguration(srv.getName())
    if ( ! host ) {
      desc.addHostConfiguration(srv)
    } else {
      // copy objects
      InvokerHelper.setProperties(host, srv.properties)
    }

    desc.save()
  }

  void possh_del_ssh_server(String... arguments ) {
    util.requirePlugin('publish-over-ssh')

    def map = util.argsToMap(arguments)
    def j = Jenkins.get()
    def desc = j.getDescriptor("jenkins.plugins.publish_over_ssh.BapSshPublisherPlugin")

    desc.removeHostConfiguration(map.name)
    desc.save()
  }
  
  void possh_insync_ssh_server(String... arguments ) {

    util.requirePlugin('publish-over-ssh')
    def mapShould = util.argsToMap(arguments)

    if ( mapShould.key ) {
      mapShould.key = util.decodeKey(mapShould.key)
    }

    // create a new sshHost object, to fill in the defaults
    def srv = mapToPosshHost(mapShould)
    mapShould = posshHostToMap(srv)
    mapShould = util.mapRemoveAllNull(mapShould)
    // remove the password - jenkns empties this field 
    mapShould.remove('password')

    def j = Jenkins.get()
    def desc = j.getDescriptor("jenkins.plugins.publish_over_ssh.BapSshPublisherPlugin")

    def host = desc.getConfiguration(mapShould.name)
    
    def mapIs = posshHostToMap(host)
    mapIs = util.mapRemoveAllNull(mapIs)
    // remove the password - jenkns empties this field 
    mapIs.remove('password')
    out.println(mapShould.equals(mapIs))
  }

} // class Actions


///////////////////////////////////////////////////////////////////////////////
// CLI Argument Processing
///////////////////////////////////////////////////////////////////////////////

def bindings = getBinding()
actions = new Actions(out, bindings)
action = args[0]
if (args.length < 2) {
  actions."$action"()
} else {
  actions."$action"(*args[1..-1])
}
