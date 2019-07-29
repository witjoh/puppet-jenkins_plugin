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
import hudson.model.*
import hudson.util.*
import hudson.security.*
import jenkins.model.*
import jenkins.security.*
import org.apache.commons.io.IOUtils
import org.jenkinsci.plugins.*
import jenkins.security.plugins.ldap.*


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

  /////////////////////
  // Following actions configure LDAP
  ////////////////////

  ////////////////////
  // Helper to convert string to idStrategy class
  ////////////////////

  jenkins.model.IdStrategy string2IdStrategy( String id ) {

    switch (id.toLowerCase()) {
      case 'casesensitiveemailaddress':
      case 'case_sensitive_emailaddress':
      case '2':
         return new IdStrategy.CaseSensitiveEmailAddress()
      break;
      case 'casesensitive':
      case 'case_sensitive':
      case '1':
        return new IdStrategy.CaseSensitive()
      break;
      case 'caseinsensitive':
      case 'case_insensitive':
      case '0':
        return new IdStrategy.CaseInsensitive()
      break;
      default:
        throw new Exception("Unknown Case Handling setting: " + id)
      break;
    }
  }

  // retrieve the ldap security realm, 
  LDAPSecurityRealm getLdapSecurityRealm() {
    util.requirePlugin('ldap')

    def j=Jenkins.get()
    def realm = j.getSecurityRealm()
    if ( realm.getClass().getName() != 'hudson.security.LDAPSecurityRealm' ) {
      return null  // we dont have ldap configured yet
    }
    return realm
  }

  // generate a map of the 'advanced settings' sections in the GUI
  LinkedHashMap ldapSecurityRealmToMap(LDAPSecurityRealm realm) {
    def map = [:]
    if ( realm ) {
      map << [ disableroleprefixing: realm.isDisableRolePrefixing() ]
      map << [ disablemailaddressresolver: realm.disableMailAddressResolver ]
      map << [ useridstrategy: realm.getUserIdStrategy().getClass().getName().tokenize('$')[1] ]
       map << [ groupidstrategy: realm.getGroupIdStrategy().getClass().getName().tokenize('$')[1] ]
      if ( realm.getCache() ) {
        map << [ cachesize: realm.getCache().getSize() ]
        map << [ cachettl: realm.getCache().getTtl() ]
      }
      map = util.mapRemoveAllNull(map)
    }
    return map
  }

  Integer roundCacheSize ( String cache ) {
    if (cache) {
      switch (cache.toInteger()) {
        case 1000..Integer.MAX_VALUE:
          return 1000
        case 500..999:
          return 500
        case 200..499:
          return 200
        case 100..199:
          return 100
        case 50..99:
          return 50
        case 20..49: 
          return 20
        default:
          return 10
      }
    }
    return 10
  }

  Integer roundCacheTtl( String ttl ) {
    if (ttl) {
      switch (ttl.toInteger()) {
        case 0..59:
          return 30
        case 60..119:
          return 60
        case 120..299:
          return 120
        case 300..599:
          return 300
        case 600..899:
          return 600
        case 900..1799:
          return 900
        default:
          return 36000
      } 
    }
    return 300
  }
      
  LDAPSecurityRealm settingsMapToLdapSecurityRealm(LinkedHashMap map) {
    def realm = null
    if (map) {
      realm = getLdapSecurityRealm()
      if (realm) {
        def ldapConfigurations = realm.getConfigurations()
        def ldapCache = null
        if (map.cachesize) {
          ldapCache = new LDAPSecurityRealm.CacheConfiguration(roundCacheSize(map.cachesize), roundCacheTtl(map.cachettl))
        }
        realm = new LDAPSecurityRealm(
          ldapConfigurations,
          map.disablemailaddressresolver ? map.disablemailaddressresolver.toBoolean() : false,
          ldapCache,
          map.useridstrategy ? string2IdStrategy(map.useridstrategy) : 0,
          map.groupidstrategy ? string2IdStrategy(map.groupidstrategy) : 0,
        )
        realm.setDisableRolePrefixing(map.disableroleprefixing ? map.disableroleprefixing.toBoolean() : false)
      }
    }
    return realm
  }

  // returns the index of the server config in the configurtion list
  String getConfigId(String server, LDAPSecurityRealm realm) {
    def id = null
    if (realm) {
       realm.getConfigurations().eachWithIndex { cfg, i ->
         if ( cfg.getServer() == server ) {
           id = cfg.getId()
         }
       }
    }
    return id
  }

  Integer getConfigIndex(String server, LDAPSecurityRealm realm) {
    def index = null
    if (realm) {
      realm.getConfigurations().eachWithIndex { cfg, i ->
        if ( cfg.getServer() == server ) {
          index = i
        }
      }
    }
    return index
  }

  LinkedHashMap ldapConfigurationToMap(LDAPConfiguration cfg) {
    def map = [:]
    if (cfg) {
      map << [ server: cfg.getServer() ]
      map << [ rootdn: cfg.getRootDN() ]
      map << [ usersearchbase: cfg.getUserSearchBase() ]
      map << [ usersearch: cfg.getUserSearch() ]
      map << [ groupsearchbase: cfg.getGroupSearchBase() ]
      map << [ groupsearchfilter: cfg.getGroupSearchFilter() ]
      map << [ managerdn: cfg.getManagerDN() ]
      //map << [ managerpassword: cfg.getManagerPasswordSecret().getEncryptedValue() ]
      map << [ managerpassword: cfg.getManagerPassword() ]
      map << [ inhibitinferrootdn: cfg.isInhibitInferRootDN() ]
      map << [ displaynameattributename: cfg.getDisplayNameAttributeName() ]
      map << [ mailaddressattributename: cfg.getMailAddressAttributeName() ]
      map = util.mapRemoveAllNull(map)
    }
    return map
  }

  LDAPConfiguration mapToLdapConfiguration(LinkedHashMap map){
    def cfg = null
    if (map) {
      cfg = new LDAPConfiguration(
        map.server,
        map.rootdn,
        map.inhibitinferootdn ? map.inhibitinferootdn.toBoolean() : false,
        map.managerdn,
        Secret.fromString(map.managerpassword))

      cfg.setDisplayNameAttributeName(map.displaynameattributename ? map.displaynameattributename : 'displayName')
      cfg.setGroupSearchBase(map.groupsearchbase)
      cfg.setGroupSearchFilter(map.groupsearchfilter)
      cfg.setMailAddressAttributeName(map.mailaddressattributename ? map.mailaddressattributename : 'mail')
      cfg.setUserSearch( map.usersearch ? map.usersearch : 'uid=(0)')
      cfg.setUserSearchBase(map.usersearchbase)
    }
    return cfg
  }

  ////////////////////
  // get global ldap settings
  ////////////////////

  void ldap_get_settings() {

    def realm = getLdapSecurityRealm() 
    if (realm) {
      def ldapMap = ldapSecurityRealmToMap(realm)
      util.printMap(ldapMap)
    }
  }

  ////////////////////
  // create or update ldap realm and global settings
  ////////////////////

  void ldap_set_settings(String... arguments) {
    util.requirePlugin('ldap')
    def ldapMap = util.argsToMap(arguments)
    def ldapRealm = settingsMapToLdapSecurityRealm(ldapMap)
    if (ldapRealm) {
      def j = Jenkins.get()
      j.setSecurityRealm(ldapRealm)
      j.save()
    }
  }

  void ldap_insync_settings(String... arguments) {
    def mapShould = ldapSecurityRealmToMap((settingsMapToLdapSecurityRealm(util.argsToMap(arguments))))
    def realm = getLdapSecurityRealm()
    def mapIs = [:]
    if (realm) {
      mapIs = ldapSecurityRealmToMap(realm)
    }
    out.println(mapIs.equals(mapShould))
  }

  ////////////////////
  // get ldap server
  ////////////////////

  void ldap_get_server(String server) {
    def realm = getLdapSecurityRealm()
    if (realm) {
      def ldapConf = realm.getConfigurationFor(getConfigId(server, realm))
      def srvMap = ldapConfigurationToMap(ldapConf)
      util.printMap(srvMap)
    }
  }

  ////////////////////
  // set ldap server
  ////////////////////

  void ldap_set_server(String... arguments) {
    def srv = mapToLdapConfiguration(util.argsToMap(arguments)) 
    def realm = getLdapSecurityRealm()
    def cfgList = []
    // no ldap server defined
    if (realm == null ) {
      cfgList.add(srv)
      // create a new one, with the defaults
      realm = new LDAPSecurityRealm(
        cfgList,
        false,
        new LDAPSecurityRealm.CacheConfiguration(0, 0),
        string2IdStrategy('0'),
        string2IdStrategy('0')
      )
      Jenkins.get().setSecurityRealm(realm)
    } else {
      // ldap real exists, updating
      cfgList = realm.getConfigurations()
      def cfgIndex = getConfigIndex(srv.getServer(), realm)
      if (cfgIndex != null) {
        cfgList.putAt(cfgIndex, srv)
      } else {
        cfgList.add(srv)
      }
    }
    Jenkins.get().save()
  }

  /////////////////////
  // ldap_server_insync
  ////////////////////

  void ldap_insync_server(String... arguments){
    def mapShould = ldapConfigurationToMap(mapToLdapConfiguration(util.argsToMap(arguments)))
    def realm = getLdapSecurityRealm()
    def mapIs =[:]
    if (realm) {
      mapIs = ldapConfigurationToMap(realm.getConfigurationFor(getConfigId(mapShould.server, realm)))
    }

    out.println(mapShould.equals(mapIs))
  }

  ////////////////////
  // delete ldap server configuration
  ////////////////////

  void ldap_del_server(String server){
    def realm = getLdapSecurityRealm()
    if (realm) {
      def cfgList =  realm.getConfigurations()
      def cfgIndex = getConfigIndex(server, realm)
      if (cfgIndex != null) {
        cfgList.removeAt(cfgIndex)
      }
    }
    Jenkins.get().save()
  }

  ////////////////////
  // end LDAP actions
  ////////////////////

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
