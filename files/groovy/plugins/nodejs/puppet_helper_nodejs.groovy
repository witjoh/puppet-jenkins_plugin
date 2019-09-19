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
import jenkins.model.*
import hudson.model.*
import jenkins.plugins.nodejs.tools.*
import hudson.tools.*

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

  LinkedHashMap nodejsInstallationToMap( NodeJSInstallation inst ) {
    def map = [:]
    if (inst) {
      map << [ name: inst.getName() ]
      map << [ home: inst.getHome() ]
    }
    return map
  }

  NodeJSInstallation mapToNodejsInstallation (LinkedHashMap map ) {
    def inst = null
    if (map) {
      inst = new NodeJSInstallation(map['name'], map['home'], [])
    }
    return inst
  }

  NodeJSInstallation lookupNodejsInstallation(String name) {
    def j = Jenkins.get()
    def desc = j.getDescriptor("jenkins.plugins.nodejs.tools.NodeJSInstallation")
    def inst = desc.getInstallations()
    return inst.find { it.getName() == name }
  }

  void modifyNodejsInstallations(NodeJSInstallation inst, ModifyAction action) {
    if (inst) {
      def j = Jenkins.get()
      def desc = j.getDescriptor("jenkins.plugins.nodejs.tools.NodeJSInstallation")
      def lst = desc.getInstallations()
      def lstNew = []
      def found = false
      lst.each {
        if ( it.getName() == inst.getName() ) {
          switch (action) {
            case ModifyAction.SET: S:{
              lstNew.add(inst)
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
        lstNew.add(inst)
      }
      desc.setInstallations((NodeJSInstallation[]) lstNew)
      desc.save()
    }
  }

  //////////////////////////////////////////////////////////////////////////////
  // Helper functions for nodejs installations configuration
  //////////////////////////////////////////////////////////////////////////////

  void insync_nodejs_installation(String... args) {
    def mapShould = util.argsToMap(args)
    def mapIs = nodejsInstallationToMap(lookupNodejsInstallation(mapShould['name']))
    out.println(mapShould.equals(mapIs))
  }

  void get_nodejs_installations() {
    def j = Jenkins.get()
    def desc = j.getDescriptor("jenkins.plugins.nodejs.tools.NodeJSInstallation")
    def inst = desc.getInstallations()
    inst.each {
      util.printMap(nodejsInstallationToMap(it))
    }
  }

  void get_nodejs_installation(String name) {
     util.printMap(nodejsInstallationToMap(lookupNodejsInstallation(name)))
  }

  void set_nodejs_installation(String... arguments) {
    def inst = mapToNodejsInstallation(util.argsToMap(arguments))
    modifyNodejsInstallations(inst, ModifyAction.SET)
  }

  void del_nodejs_installation(String... arguments) {
    def inst = lookupNodejsInstallation(util.argsToMap(arguments)['name'])
    modifyNodejsInstallations(inst, ModifyAction.DELETE)
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
