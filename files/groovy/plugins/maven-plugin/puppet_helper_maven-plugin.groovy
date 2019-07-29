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
import jenkins.model.*
import hudson.tasks.Maven.*
import hudson.tasks.Maven.MavenInstallation

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

  LinkedHashMap mavenInstallationToMap(hudson.tasks.Maven$MavenInstallation inst) {
    def map = [:]
    if (inst) {
      map << [ name: inst.getName() ]
      map << [ mavenhome: inst.getHome() ]
    }
    map = util.mapRemoveAllNull(map)
    return map
  }

  hudson.tasks.Maven$MavenInstallation mapToMavenInstallation(LinkedHashMap map) {
    def inst = null
    if (map) {
      inst = new MavenInstallation (
        map.name,
        map.mavenhome,
        [])
    }
    return inst
  }

  hudson.tasks.Maven$MavenInstallation lookupMavenInstallation(String name) {
    def cfg = jenkins.model.Jenkins.instance.getExtensionList(hudson.tasks.Maven.DescriptorImpl.class)[0]
    def lst = cfg.getInstallations()
    def result = lst.find {
      if ( it.getName() == name ) {
        return it
      }
      return null
    }
    return result
  }

  void modifyMavenInstallations(MavenInstallation inst, ModifyAction action) {
    if (inst) {
      def cfg = jenkins.model.Jenkins.instance.getExtensionList(hudson.tasks.Maven.DescriptorImpl.class)[0]
      def lst = cfg.getInstallations()
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
      cfg.setInstallations((MavenInstallation[]) lstNew)
      cfg.save()
    }
  }

  void maven_set_installation(String... arguments) {
    def inst = mapToMavenInstallation(util.argsToMap(arguments))
    out.println(inst.getName() + " : " + inst.getHome() ) 
    out.println(inst.getClass().getName())
    modifyMavenInstallations(inst, ModifyAction.SET)
  }

  void maven_del_installation(String name) {
    def inst = lookupMavenInstallation(name)
    modifyMavenInstallations(inst, ModifyAction.DELETE)
  }

  void maven_get_installation(String name) {
    def inst = mavenInstallationToMap(lookupMavenInstallation(name))
    util.printMap(inst)
  }

  void maven_get_installations() {
    def mavenDesc = jenkins.model.Jenkins.instance.getExtensionList(hudson.tasks.Maven.DescriptorImpl.class)[0]
    if ( mavenDesc ) {
      def mavenInstallations = mavenDesc.getInstallations()
      mavenInstallations.each() { installation ->
        util.printMap(mavenInstallationToMap(installation))
      }
    }
  }

  void maven_insync_installation (String... arguments) {
    def mapShould = mavenInstallationToMap(mapToMavenInstallation((util.argsToMap(arguments))))
    def mapIs = mavenInstallationToMap(lookupMavenInstallation(mapShould.name))
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
