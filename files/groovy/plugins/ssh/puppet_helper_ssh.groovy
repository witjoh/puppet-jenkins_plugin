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
import groovy.xml.StreamingMarkupBuilder
import groovy.xml.*
import groovy.util.*
import groovy.transform.InheritConstructors
import org.codehaus.groovy.runtime.InvokerHelper
import hudson.*
import hudson.plugins.*
import hudson.model.*
import jenkins.*
import jenkins.model.*
import org.jvnet.hudson.plugins.*
import net.sf.json.JSONObject

///////////////////////////////////////////////////////////////////////////////
//  puppet helper library loading (class Util)
///////////////////////////////////////////////////////////////////////////////
File sourceFile = new File('/usr/lib/jenkins/groovy/plugins/lib/Plib.groovy')
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

  def enum ModifyAction {
    SET,
    DELETE
  }

  //////////////////////////
  // xvnc global properties
  /////////////////////////

  LinkedHashMap credentialSSHSiteToMap( CredentialsSSHSite site ) {
    def map = [:]
    if (site) {
      map << [ hostname: site.getHostname() ]
      map << [ port: site.getPort() ]
      map << [ credentialid: site.getCredentialId() ]
      map << [ pty: site.getPty() ]
      map << [ serveraliveinterval: site.getServerAliveInterval() ]
      map << [ timeout: site.getTimeout() ]
    }
    return map
  }

  CredentialsSSHSite maptToCredentialSSHSite( LinkedHashMap map ) {
    def site = null
    if (map) {
      site = new CredentialsSSHSite(
        map['hostname'], 
        (map['port']) ? map['port'] : "22", 
        map['credentialid'], 
        (map['serveraliveinterval']) ? map['serveraliveinterval'] : "0", 
        (map['timeout']) ? map['timeout'] : "0"
      ) 
      if (map['pty']) {
        site.setPty(map['pty'].toBoolean())
      }
    }
    site
  }

  CredentialsSSHSite lookupCredentialSSHSite (String hostname) {
    def site = null
    if (hostname) {
      def j = Jenkins.get()
      def ssh = j.getDescriptorByName("org.jvnet.hudson.plugins.SSHBuildWrapper")

      def ssh_hosts = ssh.getSites()
      //ssh_hosts.find { it.getHostname() == hostname }
      ssh_hosts.each() {
        if (it.getHostname() == hostname) {
          // should we do a copy by value here ?
          site = it
        }
      }
    }
    site
  }

  void modifyCredentialsSSHSites(CredentialsSSHSite site, ModifyAction action) {
    if (site) {
      def j = Jenkins.get()
      def ssh = j.getDescriptorByName("org.jvnet.hudson.plugins.SSHBuildWrapper")
      def ssh_hosts = ssh.getSites()
      def newSites = []
      def updated = false

      ssh_hosts.each { 
        switch (action) {
          case ModifyAction.SET: S: {
            if (it.getHostname() == site.getHostname() ) {
               newSites.add(site)
               updated = true
            } else {
              newSites.add(it)
            }
            break;
          }
          case ModifyAction.DELETE: D: {
            if (it.getHostname() != site.getHostname() ) {
              newSites.add(it)
            }
            break;
          }
        }
      }
      switch (action) {
        case ModifyAction.SET: S: {
          if (!updated) {
            newSites.add(site)
          }
          break;
        }
      }
      // save to the xml
      def xmlFile = new File(ssh.getConfigFile().toString())
      def myxml = new XmlParser().parse(xmlFile)
      //remove all sites
      myxml.sites[0].findAll().each() {
        myxml.sites[0].remove(it)
      }
      //and replace with current sites
      def node = null
      def map = null
      newSites.each() {
        node = new NodeBuilder().'org.jvnet.hudson.plugins.CredentialsSSHSite'() { obj = it ->
          hostname(obj.getHostname())
          username(obj.getSitename().split('@')[0])
          port(obj.getPort())
          credentialId(obj.getCredentialId())
          serverAliveInterval(obj.getServerAliveInterval())
          timeout(obj.getTimeout())
        }
        myxml.sites[0].append(node)
      }
      // write back to file
      //FileWriter fileWriter = new FileWriter('/tmp/test.xml')
      FileWriter fileWriter = new FileWriter(ssh.getConfigFile().toString())
      XmlNodePrinter nodePrinter = new XmlNodePrinter(new PrintWriter(fileWriter))
      nodePrinter.setPreserveWhitespace(true)
      nodePrinter.print(myxml)
      ssh.load()
    }
  }

  void set_ssh_remote_host(String... args) {
    def site = maptToCredentialSSHSite(util.argsToMap(args))
    modifyCredentialsSSHSites(site, ModifyAction.SET)
  }

  void del_ssh_remote_host(String... args) {
    def site = maptToCredentialSSHSite(util.argsToMap(args))
    modifyCredentialsSSHSites(site, ModifyAction.DELETE)
  }

  void insync_ssh_remote_host(String... args) {
    def mapShould = credentialSSHSiteToMap(maptToCredentialSSHSite(util.argsToMap(args))) 
    def mapIs = credentialSSHSiteToMap(lookupCredentialSSHSite(mapShould['hostname']))
    out.println(mapShould.equals(mapIs))
  }

  void get_ssh_remote_host( String hostname) {
    def site = lookupCredentialSSHSite(hostname)
    util.printMap(credentialSSHSiteToMap(site))
  }

  void get_ssh_remote_hosts() {
    def j = Jenkins.get()
    def ssh = j.getDescriptorByName("org.jvnet.hudson.plugins.SSHBuildWrapper")

    def ssh_hosts = ssh.getSites()
    def map = null
    ssh_hosts.each() {
      util.printMap(credentialSSHSiteToMap(it))
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
