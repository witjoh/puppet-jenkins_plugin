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
import hudson.plugins.sonar.*
import hudson.plugins.sonar.SonarGlobalConfiguration
import hudson.plugins.sonar.SonarRunnerInstallation
import hudson.plugins.sonar.model.TriggersConfig

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


  //////////////////////////////////////////////////////////////////////////////
  //  Sonar Global Configuration Section
  //////////////////////////////////////////////////////////////////////////////

  LinkedHashMap sonarInstallationToMap(hudson.plugins.sonar.SonarInstallation inst) {
    def map = [:]
    if (inst ) {
      map << [ name: inst.getName() ]
      map << [ serverurl: inst.getServerUrl() ]
      map << [ credentialsid: inst.getCredentialsId() ]
      map << [ mojoversion: inst.getMojoVersion() ]
      map << [ additionalanalysisproperties: inst.getAdditionalAnalysisProperties() ]
      map << [ additionalproperties: inst.getAdditionalProperties() ]
    }
    map = util.mapRemoveAllNull(map)
    return map
  }

  hudson.plugins.sonar.SonarInstallation  mapToSonarInstallation(LinkedHashMap map) {
    def inst = null
    if (map) {
      inst = new SonarInstallation (
        map.name,
        map.serverurl,
        map.credentialsid,
        null,
        map.mojoversion,
        map.additionalproperties,
        map.additionalanalysisproperties,
        new TriggersConfig(),
      )
    }
    return inst
  }

  hudson.plugins.sonar.SonarInstallation lookupSonarInstallation(String name) {
    def j = Jenkins.get()
    def SonarGlobalConfiguration global = j.getDescriptorByType(SonarGlobalConfiguration.class)
    def inst = global.getInstallations()
    def result = null
    inst.each { 
      if ( it.getName() == name ) {
        result = it
      }
    }
    return result
  }

  void modifySonarInstallations(SonarInstallation inst, ModifyAction action) {
    if (inst) {
      def j = Jenkins.get()
      def SonarGlobalConfiguration global = j.getDescriptorByType(SonarGlobalConfiguration.class)
      def instList = global.getInstallations()
      def lstNew = []
      def found = false
      instList.each {
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
      global.setInstallations((SonarInstallation[]) lstNew)
      global.save()
    }
  }

  void sonar_set_globalconfig(String... arguments) {
    def inst = mapToSonarInstallation(util.argsToMap(arguments))
    modifySonarInstallations(inst, ModifyAction.SET)
  }

  void sonar_del_globalconfig(String name) {
    def inst = lookupSonarInstallation(name)
    modifySonarInstallations(inst, ModifyAction.DELETE)
  }

  void sonar_get_globalconfig(String name) {
    def inst = lookupSonarInstallation(name)
    util.printMap(sonarInstallationToMap(inst))
  }

  void sonar_get_globalconfigs() {
    def j = Jenkins.get()
    def SonarGlobalConfiguration global = j.getDescriptorByType(SonarGlobalConfiguration.class)
    def inst = global.getInstallations()
    inst.each { 
      util.printMap(sonarInstallationToMap(it))
    }
  }

  void sonar_insync_globalconfig(String... arguments) {
    def mapShould = sonarInstallationToMap(mapToSonarInstallation((util.argsToMap(arguments))))
    def mapIs = sonarInstallationToMap(lookupSonarInstallation(mapShould.name))
    out.println(mapShould.equals(mapIs))
  }

  ///////////////////////////////////////////////////////////////////////////////
  // Sonar Runner Installetion Section
  ///////////////////////////////////////////////////////////////////////////////

  LinkedHashMap sonarRunnerInstallationToMap(hudson.plugins.sonar.SonarRunnerInstallation inst) {
    def map = [:]
    if (inst ) {
      map << [ name: inst.getName() ]
      map << [ home: inst.getHome() ]
    }
    map = util.mapRemoveAllNull(map)
    return map
  }

  hudson.plugins.sonar.SonarRunnerInstallation  mapToSonarRunnerInstallation(LinkedHashMap map) {
    def inst = null
    if (map) {
      inst = new SonarRunnerInstallation (
        map.name,
        map.home,
        []
      )
    }
    return inst
  }

  hudson.plugins.sonar.SonarRunnerInstallation lookupSonarRunnerInstallation(String name) {
    def j = Jenkins.get()
    def descSonarRunnerInst = j.getDescriptor("hudson.plugins.sonar.SonarRunnerInstallation")
    def sonarRunnerInstallations = descSonarRunnerInst.getInstallations()
    def result = null
    sonarRunnerInstallations.each { 
      if ( it.getName() == name ) {
        result = it
      }
    }
    return result
  }

  void modifySonarRunnerInstallations(SonarRunnerInstallation inst, ModifyAction action) {
    if (inst) {
      def j = Jenkins.get()
      def descSonarRunnerInst = j.getDescriptor("hudson.plugins.sonar.SonarRunnerInstallation")
      def instList = descSonarRunnerInst.getInstallations()
      def lstNew = []
      def found = false
      instList.each {
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
      descSonarRunnerInst.setInstallations((SonarRunnerInstallation[]) lstNew)
      descSonarRunnerInst.save()
    }
  }

  void sonar_set_runner(String... arguments) {
    def inst = mapToSonarRunnerInstallation(util.argsToMap(arguments))
    modifySonarRunnerInstallations(inst, ModifyAction.SET)
  }

  void sonar_del_runner(String name) {
    def inst = lookupSonarRunnerInstallation(name)
    modifySonarRunnerInstallations(inst, ModifyAction.DELETE)
  }

  void sonar_get_runner(String name) {
    def inst = lookupSonarRunnerInstallation(name)
    util.printMap(sonarRunnerInstallationToMap(inst))
  }

  void sonar_get_runners() {
    def j = Jenkins.get()
    def descSonarRunnerInst = j.getDescriptor("hudson.plugins.sonar.SonarRunnerInstallation")
    def sonarRunnerInstallations = descSonarRunnerInst.getInstallations()
    sonarRunnerInstallations.each { 
      util.printMap(sonarRunnerInstallationToMap(it))
    }
  }

  void sonar_insync_runner(String... arguments) {
    def mapShould = sonarRunnerInstallationToMap(mapToSonarRunnerInstallation((util.argsToMap(arguments))))
    def mapIs = sonarRunnerInstallationToMap(lookupSonarRunnerInstallation(mapShould.name))
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
