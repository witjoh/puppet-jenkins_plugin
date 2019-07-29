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
import hudson.model.*
import jenkins.*
import jenkins.model.*
import jenkins.metrics.*

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

  def enum ModifyAction {
    SET,
    DELETE
  }

  //////////////////////////////////////////////////////////////////////////////
  // Helper functions specific for this plugin
  //////////////////////////////////////////////////////////////////////////////

  LinkedHashMap graphiteServerToMap(jenkins.metrics.impl.graphite.GraphiteServer srv) {
    util.requirePlugin('metrics-graphite')
    def map = [:]
    if (srv) {
      map << [ hostname: srv.getHostname() ]
      map << [ port: srv.getPort().toString() ]
      map << [ prefix: srv.getPrefix() ]
    }
    map = util.mapRemoveAllNull(map)
    return map
  }

  jenkins.metrics.impl.graphite.GraphiteServer mapToGraphiteServer(LinkedHashMap map) {
    def srv = null
    if (map) {
      srv = new jenkins.metrics.impl.graphite.GraphiteServer(
        map.hostname,
        map.port ? map.port.toInteger() : 2003,
        map.prefix)
    }
    return srv
  }

  // add or update a Graphiteserver object to the List<GraphiteServer>

  void modifyGraphiteServer(jenkins.metrics.impl.graphite.GraphiteServer srv, ModifyAction action) {
    util.requirePlugin('metrics-graphite')
    if (srv) {
      def cfg = Jenkins.get().getDescriptorByName("jenkins.metrics.impl.graphite.GraphiteServer")
      def lst = cfg.getServers()
      def lstNew = [] 
      def found = false
      lst.each { 
        if ( it.getHostname() == srv.getHostname() ) {
          switch (action) {
            case ModifyAction.SET: S:{
              lstNew.add(srv)
              found = true
              break;
            }
            case ModifyAction.DELETE: D:{
              break;
            }
          }
        } else {
          lstNew.add(it)
        }
      }
      if (!found &&  action == ModifyAction.SET ) {
        lstNew.add(srv)
      }
      cfg.setServers(lstNew)
      cfg.save()
    }
  }

  jenkins.metrics.impl.graphite.GraphiteServer lookupGraphiteServer(String hostname) {
    util.requirePlugin('metrics-graphite')
    if (hostname) {
      def cfg = Jenkins.get().getDescriptorByName("jenkins.metrics.impl.graphite.GraphiteServer")
      def lst = cfg.getServers()
      def result = lst.find { 
        if ( it.getHostname() == hostname ) {
          return it
        }
        return null
      }
      return result
    }
  }

  void graphite_set_server(String... arguments) {
    def server = mapToGraphiteServer(util.argsToMap(arguments))
    modifyGraphiteServer(server, ModifyAction.SET)    
  }

  void graphite_del_server(String hostname) {
    def srv = lookupGraphiteServer(hostname)
    modifyGraphiteServer(srv, ModifyAction.DELETE)
  }

  void graphite_get_server(String hostname ) {
    def map = graphiteServerToMap(lookupGraphiteServer(hostname))
    util.printMap(map)
  }

  void graphite_getall_servers() {
    util.requirePlugin('metrics-graphite')
    def map = [:]
    def conf = Jenkins.get().getDescriptorByName("jenkins.metrics.impl.graphite.GraphiteServer")
    if ( conf ) {
      def list = conf.getServers()
      list.each {
        map = graphiteServerToMap(it)
        util.printMap(map)
      }
    }
  }

  void graphite_insync_server (String... arguments) {
    def mapShould = graphiteServerToMap(mapToGraphiteServer(util.argsToMap(arguments)))
    def mapIs = graphiteServerToMap(lookupGraphiteServer(mapShould.hostname))
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
