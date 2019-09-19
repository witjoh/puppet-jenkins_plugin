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

  def enum ModifyAction {
    SET,
    DELETE
  }


  /////////////////////
  // jdk installations
  /////////////////////

  LinkedHashMap jdkToMap( JDK jdk ) {
    def map = [:]
    if (jdk) {
      map << [name: jdk.getName() ]
      map << [javahome: jdk.getHome() ]
    }
    return map
  }

  JDK mapToJdk (LinkedHashMap map) {
    def jdk = null
    if (map) {
      jdk = new JDK(map['name'], map['javahome'])
    }
    return jdk
  }

  void modifyJdkList(JDK jdk, ModifyAction action) {
    if (jdk) {
      def j = Jenkins.get()
      def jdkDescr = j.getDescriptorByName("hudson.model.JDK")
      def jdkList = jdkDescr.getInstallations()
      def newList = new ArrayList<JDK>()
      def updated = false

      jdkList.each {
        switch (action) {
          case ModifyAction.SET: S: {
            if (it.getName() == jdk.getName() ) {
              newList.add(jdk)
              updated = true
            } else {
              newList.add(it)
            }
            break;
          }
          case ModifyAction.DELETE: D: {
            if (it.getName() == jdk.getName() ) {
              updated = true
            } else {
              newList.add(it)
            }
            break;
          }
        }
      }
      if (!updated) {
        newList.add(jdk)
      }
      jdkDescr.setInstallations(newList.toArray(new JDK[0]))
      jdkDescr.save()
      j.save()
    }
  }

  JDK lookupJdk( String name ) {
    def JDKDesc = Jenkins.instance.getDescriptorByName("hudson.model.JDK");
    def list = JDKDesc.getInstallations()
    def jdk = list.find() { it.getName() == name }
    return jdk 
  }

  void get_jdk_installations() {
    def JDKDesc = Jenkins.instance.getDescriptorByName("hudson.model.JDK");
    def list = JDKDesc.getInstallations()
    list.each() {
      util.printMap(jdkToMap(it))
    }
  }

  void set_jdk_installation(String... arguments) {
    def map = util.argsToMap(arguments)
    modifyJdkList(mapToJdk(map), ModifyAction.SET)
  }

  void del_jdk_installation(String... arguments) {
    def map = util.argsToMap(arguments)
    modifyJdkList(mapToJdk(map), ModifyAction.DELETE)
  }
  
  void get_jdk_installation(String... arguments) {
    def map = util.argsToMap(arguments)
    util.printMap(jdkToMap(lookupJdk(map['name'])))
  }

  void insync_jdk_installation(String... arguments) {
    def mapIs = util.argsToMap(arguments)
    def mapShould = jdkToMap(lookupJdk(mapIs['name']))
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
