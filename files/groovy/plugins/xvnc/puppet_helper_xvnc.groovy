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
import hudson.plugins.*
import hudson.model.*
import jenkins.*
import jenkins.model.*
import hudson.plugins.xvnc.*

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

  /////////////////////
  // xvnc actions
  /////////////////////

  LinkedHashMap xvncToMap( hudson.plugins.xvnc.Xvnc$DescriptorImpl cfg ) {
    def map = [:]
    if (cfg) {
      map << [ commandline: cfg.getCommandline() ]
      map << [ mindisplaynumber: cfg.minDisplayNumber ]
      map << [ maxdisplaynumber: cfg.maxDisplayNumber ]
      map << [ cleanup: cfg.cleanUp ]
      map << [ skiponwindows: cfg.skipOnWindows ]
    }
    return map
  }

  hudson.plugins.xvnc.Xvnc$DescriptorImpl mapToXvnc( LinkedHashMap map ) {
    def cfg = null
    if ( map ) {
      cfg = new Xvnc.DescriptorImpl()
      def result = cfg.doCheckCommandline(map.commandline).toString()
      if ( result.take(2) == 'OK' ) {
        cfg.setCommandline(map.commandline)
        cfg.minDisplayNumber = map.mindisplaynumber?.toInteger() ?: 10
        cfg.maxDisplayNumber = map.maxdisplaynumber?.toInteger() ?: 99
        cfg.cleanUp =  (map.cleanup) ? map.cleanup.toBoolean() : Boolean.FALSE
        cfg.skipOnWindows = (map.skiponwindows) ? map.skiponwindows.toBoolean() : Boolean.TRUE
      } else {
        throw new Exception(result)
      }
    }
    return cfg
  }

  void set_xvnc ( String... arguments ) {

    util.requirePlugin('xvnc')
    def newCfg = mapToXvnc( util.argsToMap(arguments) ) 

    def j = Jenkins.get()
    def xvnc = j.getDescriptorByName("hudson.plugins.xvnc.Xvnc")

    if ( newCfg) { 
      InvokerHelper.setProperties(xvnc, newCfg.properties)

      // copy the object does not see the fields other then commandline
      xvnc.minDisplayNumber = newCfg.minDisplayNumber
      xvnc.maxDisplayNumber = newCfg.maxDisplayNumber
      xvnc.cleanUp = newCfg.cleanUp
      xvnc.skipOnWindows = newCfg.skipOnWindows
    } else {
      xvnc = newCfg
    }

    j.save()
  }

  void get_xvnc() {

    util.requirePlugin('xvnc')

    def j = Jenkins.get()
    def xvnc = j.getDescriptorByName("hudson.plugins.xvnc.Xvnc")
    out.println(xvncToMap(xvnc).toMapString()?.replaceAll(/, /,/ /))
  }

  void insync_xvnc ( String... arguments ) {
    
    util.requirePlugin('xvnc')
    // map -> xvnc -> map xvnc object to get the defauts
    def x = mapToXvnc( util.argsToMap(arguments) ) 
    def shouldCfg = xvncToMap(x)


    def j = Jenkins.get()
    def xvnc = j.getDescriptorByName("hudson.plugins.xvnc.Xvnc")
    def isCfg = xvncToMap(xvnc)

    out.println(shouldCfg.equals(isCfg))
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
