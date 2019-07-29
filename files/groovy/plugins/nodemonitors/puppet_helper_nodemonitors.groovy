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
import hudson.node_monitors.*
import jenkins.*
import jenkins.model.*

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

  LinkedHashMap monitorsToMap( hudson.util.DescribableList lst ) {
    def map = [:]
    lst.each()  {
      switch ( it.getClass().getName() ) {
        case 'hudson.node_monitors.ClockMonitor':
          map << [ clock: (!(it.isIgnored())).toString() ]
          break
        case 'hudson.node_monitors.DiskSpaceMonitor':
          map << [ diskspace : (!(it.isIgnored())).toString() ]
          map << [ diskspacethreshold: it.getThresholdBytes() ]
          break
        case 'hudson.node_monitors.SwapSpaceMonitor':
          map << [swapspace: (!(it.isIgnored())).toString() ]
          break
        case 'hudson.node_monitors.ArchitectureMonitor':
          map << [architecture: (!(it.isIgnored())).toString() ]
          break
        case 'hudson.node_monitors.TemporarySpaceMonitor':
          map << [tempspace: (!(it.isIgnored())).toString() ]
          map << [tempspacethreshold: it.getThresholdBytes() ]
          break
        case 'hudson.node_monitors.ResponseTimeMonitor':
          map << [responsetime: (!(it.isIgnored())).toString() ]
          break
      }
    }
    return map
  }

  LinkedHashMap convertThresholds(LinkedHashMap map) {

    if (map) {
      if (map['diskspacethreshold']) {
        def t = new hudson.node_monitors.DiskSpaceMonitor(map['diskspacethreshold'])
        map['diskspacethreshold'] = t.getThresholdBytes()
      }

      if ( map['tempspacethreshold'] ) {
        def u = new hudson.node_monitors.TemporarySpaceMonitor(map['tempspacethreshold'])
        map['tempspacethreshold'] = u.getThresholdBytes()
      }
    }
    return map
  }
  
/*
   hudson.util.DescribableList mapToMonitors( LinkedHashMap map ) {
     ComputerSet is an imutable object, so this functions will never
     work, because we are changing this object ...
  }
*/

  void set_monitors ( String... arguments ) {

    def cfg = util.argsToMap(arguments)  
    def mon = ComputerSet.getMonitors()
    // tresholds for disk space monitor is readonly field
    if ( cfg['diskspacethreshold'] ) {
      mon.replace(new hudson.node_monitors.DiskSpaceMonitor(cfg['diskspacethreshold']))
    }
    if ( cfg['tempspacethreshold'] ) {
      mon.replace(new hudson.node_monitors.TemporarySpaceMonitor(cfg['tempspacethreshold']))
    }
    mon.each() {
      switch ( it.getClass().getName() ) {
        case 'hudson.node_monitors.ClockMonitor':
          it.setIgnored(!(cfg['clock'].toBoolean()))
          break
        case 'hudson.node_monitors.DiskSpaceMonitor':
          it.ignored = !(cfg['diskspace'].toBoolean())
          //it.thresholdBytes = cfg['diskspacetreshold']
          break
        case 'hudson.node_monitors.SwapSpaceMonitor':
          it.ignored = !(cfg['swapspace'].toBoolean())
          break
        case 'hudson.node_monitors.ArchitectureMonitor':
          it.ignored = !(cfg['architecture'].toBoolean())
          break
        case 'hudson.node_monitors.TemporarySpaceMonitor':
          it.ignored = !(cfg['tempspace'].toBoolean())
          //it.thresholdBytes = cfg['tempspacetreshold']
          break
        case 'hudson.node_monitors.ResponseTimeMonitor':
          it.ignored = !(cfg['responsetime'].toBoolean())
          break
      }
    }
  }

  void get_monitors() {

    def mon = ComputerSet.getMonitors()
    def map = monitorsToMap(mon)
    util.printMap(map)

  }

  void insync_monitors ( String... arguments ) {
    
    //def x = mapToMonitors( util.argsToMap(arguments) ) 
    //def shouldCfg = monitorsToMap(x)
    def shouldCfg = util.argsToMap(arguments)
    // tresholds are internally stored in bytes
    shouldCfg = convertThresholds(shouldCfg)    
    def mon = ComputerSet.getMonitors()
    def isCfg = monitorsToMap(mon)

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
