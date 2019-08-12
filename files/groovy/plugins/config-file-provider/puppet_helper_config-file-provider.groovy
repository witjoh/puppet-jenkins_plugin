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
import hudson.*
import jenkins.*
import hudson.model.*
import hudson.tools.*
import jenkins.model.*
import org.jenkinsci.plugins.configfiles.*
import org.jenkinsci.plugins.configfiles.maven.security.*

@InheritConstructors
class MissingRequiredPlugin extends Exception {}

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

// add the common plib methods to the Utils class, as ig they were
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

  //////////////////////////////////////////////////////////////////////////////
  // Helper functions specific for this plugin
  //////////////////////////////////////////////////////////////////////////////


  //////////////////////////////////////////////////////////////////////////////
  //  Maven Global Settings
  //////////////////////////////////////////////////////////////////////////////

  LinkedHashMap globalMavenSettingsConfigToMap( org.jenkinsci.plugins.configfiles.maven.GlobalMavenSettingsConfig cfg ) {
    util.requirePlugin('config-file-provider')
    def map = [:]
    if (cfg ) {
      map << [ id: cfg.id ]
      map << [ name: cfg.name ]
      if ( map.isencoded ) {
        map << [ content: cfg.content.bytes.encodeBase64().toString() ]
      } else {
        map << [ content: cfg.content ]
      }
      map << [ comment: cfg.comment ]
      map << [ replaceall: cfg.isReplaceAll ]
      map << [ servercredentialsmapping: cfg.serverCredentialMappings ]
    }
    map = util.mapRemoveAllNull(map)
    return map
  }

  org.jenkinsci.plugins.configfiles.maven.GlobalMavenSettingsConfig mapToGlobalMavenSettingsConfig( LinkedHashMap map ) {
    util.requirePlugin('config-file-provider')
    def cfg = null
    if ( map ) {
      def contentXml = map.content
      if ( map.isencoded ) {
        def  decoded = map.content.decodeBase64()
        contentXml = new String(decoded)
      }
      // serverCredentialMappings if existing => for insync needed
      def existingCfg = lookupGlobalMavenSettingsConfig(map.id)
      def servermap = []
      if ( existingCfg ) {
        servermap = existingCfg.serverCredentialMappings
      }
      cfg = new org.jenkinsci.plugins.configfiles.maven.GlobalMavenSettingsConfig(
        map.id,
        map.name,
        map.comment,
        contentXml,
        (map.replaceall) ? map.replaceall.toBoolean() : Boolean.TRUE,
        servermap
      )
    }
    return cfg
  }

  org.jenkinsci.plugins.configfiles.maven.GlobalMavenSettingsConfig lookupGlobalMavenSettingsConfig(String id) {
    util.requirePlugin('config-file-provider')
    def j = Jenkins.get()
    def mvnConfig = j.getDescriptorByName('org.jenkinsci.plugins.configfiles.maven.GlobalMavenSettingsConfig')
    def cfg = mvnConfig.getConfigById(id)
    return cfg
  }

  void set_global_maven_settings_config(String... arguments) {
    def j = Jenkins.get()
    def mvnConfig = j.getDescriptorByName('org.jenkinsci.plugins.configfiles.maven.GlobalMavenSettingsConfig')
    def map = util.argsToMap(arguments)
    def cfg = mapToGlobalMavenSettingsConfig(map)
    mvnConfig.save(cfg)
  }

  void del_global_maven_settings_config(String... arguments) {
    def j = Jenkins.get()
    def mvnConfig = j.getDescriptorByName('org.jenkinsci.plugins.configfiles.maven.GlobalMavenSettingsConfig')
    def map = util.argsToMap(arguments)
    if ( map.id ) {
      mvnConfig.remove(map.id)
    }
  }

  void insync_global_maven_settings_config(String... arguments) {
    def mapShould = globalMavenSettingsConfigToMap(mapToGlobalMavenSettingsConfig(util.argsToMap(arguments)))
    def mapIs = globalMavenSettingsConfigToMap(lookupGlobalMavenSettingsConfig(mapShould.id))
    out.println(mapShould.equals(mapIs))
  }

  void get_global_maven_settings_config(String id) {
    def cfg = lookupGlobalMavenSettingsConfig(id)
    def map =  globalMavenSettingsConfigToMap(cfg)
    util.printMap(map)
  }

  void get_all_global_maven_settings_configs() {
    def j = Jenkins.get()
    def mvnConfig = j.getDescriptorByName('org.jenkinsci.plugins.configfiles.maven.GlobalMavenSettingsConfig')
    def all = mvnConfig.getAllConfigs()
    def map = [:]
    all.each() {
      map = globalMavenSettingsConfigToMap(it)
      util.printMap(map)
    }
  }

  ///////////////////////////////////////////////////////////////////////////////
  // Global maven settingsxml - server credetials mapping
  //
  // needs in arguments : globalMavenSettingsConfig.id mavenconfigid
  //                      credentialsid
  ///////////////////////////////////////////////////////////////////////////////
  LinkedHashMap serverCredentialMappingToMap ( ServerCredentialMapping cfg ) {
    util.requirePlugin('config-file-provider')
    def map = [:]
    if (cfg) {
      map << [ serverid: cfg.getServerId() ] 
      map << [ credentialsid: cfg.getCredentialsId() ]
    }
  }

  ServerCredentialMapping mapToServerCredentialMapping( LinkedHashMap map ) {
    util.requirePlugin('config-file-provider')
    def cfg = null
    if ( map ) {
      cfg = new ServerCredentialMapping (
        map.serverid,
        map.credentialsid
      )
    }
  }

  ServerCredentialMapping getServerCredentialMappingFromGlobalMavenConfig(String globalMavenConfigId, String serverId) {
    util.requirePlugin('config-file-provider')
    def cfg = null
    def j = Jenkins.get()
    def mvnCfg = lookupGlobalMavenSettingsConfig(globalMavenConfigId)
    if ( mvnCfg ) {
      def srvList = mvnCfg.getServerCredentialMappings()
      srvList.each() {
        if ( it.getServerId() == serverId ) {
          cfg = it
        }
      }
    }
    return cfg
  }

  void setServerCredentialMappingInGlobalMavenConfig( LinkedHashMap map ) {
    util.requirePlugin('config-file-provider')
    if (map) {
      def cfg = mapToServerCredentialMapping(map)
      def mvnCfg = lookupGlobalMavenSettingsConfig(map.globalmavenconfigid)
      if ( mvnCfg ) {
        def srvList = mvnCfg.getServerCredentialMappings()
        def replaced = false
        srvList.eachWithIndex { item, index ->
          if ( item.getServerId() == cfg.getServerId() ) {
            srvList[index] = cfg
            replaced = true
          }
        }
        if ( !replaced ) {
          srvList.add(cfg)
        }
      }
    }
  }

  void delServerCredentialMappingFromGlobalMavenConfig( LinkedHashMap map ) {
    util.requirePlugin('config-file-provider')
    if (map) {
      def mvnCfg = lookupGlobalMavenSettingsConfig(map.globalmavenconfigid)
      if ( mvnCfg ) {
        def cfg = null
        def srvList = mvnCfg.getServerCredentialMappings()
        srvList.each() {
          if ( it.getServerId() == map.serverid ) {
            cfg = it
          }
        }
        if (cfg) {
          srvList.remove(cfg)
        }
      }
    }
  }

  void insync_global_maven_server_mapping(String... arguments) {
    // we use the following map entries:
    // * globalmavenconfigid
    // * serverid
    // * credentialsid
    def mapShould = util.argsToMap(arguments)
    def cfg = getServerCredentialMappingFromGlobalMavenConfig(mapShould.globalmavenconfigid, mapShould.serverid)
    def mapIs = serverCredentialMappingToMap(cfg)
    if ( mapIs ) {
      mapIs << [ globalmavenconfigid: mapShould.globalmavenconfigid ]
    }
    out.println(mapShould.equals(mapIs))
  }

  void set_global_maven_server_mapping(String... arguments) {
    // we use the following map entries:
    // * globalmavenconfigid
    // * serverid
    // * credentialsid
    def map = util.argsToMap(arguments)
    setServerCredentialMappingInGlobalMavenConfig(map)
  }

  void del_global_maven_server_mapping(String... arguments) {
    // we use the following map entries:
    // * globalmavenconfigid
    // * serverid
    def map = util.argsToMap(arguments)
    delServerCredentialMappingFromGlobalMavenConfig(map)
  }
       
  void get_global_maven_server_mapping(String... arguments) {
    // we use the following map entries:
    // * globalmavenconfigid
    // * serverid
    def map = util.argsToMap(arguments)
    def cfg = getServerCredentialMappingFromGlobalMavenConfig(map.globalmavenconfigid, map.serverid)
    if (cfg) {
      util.printMap(serverCredentialMappingToMap(cfg))
    }
  }
       
  void get_global_maven_server_mappings(String globalMavenConfigId) {
    def j = Jenkins.get()
    def mvnCfg = lookupGlobalMavenSettingsConfig(globalMavenConfigId)
    def srvList = mvnCfg.getServerCredentialMappings()
    util.printAllMethods(srvList)
    out.println(srvList)
    srvList.each() {
      util.printMap(serverCredentialMappingToMap(it))
    }
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
