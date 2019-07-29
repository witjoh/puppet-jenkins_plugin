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
import com.cloudbees.hudson.plugins.folder.*
import com.cloudbees.hudson.plugins.foldersplus.*
import org.jenkinsci.plugins.workflow.job.WorkflowJob
import jenkins.model.Jenkins

///////////////////////////////////////////////////////////////////////////////
//  puppet helper library loading (class Util)
///////////////////////////////////////////////////////////////////////////////

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

  Boolean folderExists(String folder) {
    def folderItem = Jenkins.instance.getAllItems(Folder.class).find{it.getItemGroup().getFullName().equals(folder)}
    return folderItem ? true : false
  }

  String getParentFolders(String folder) {
    folder = folder - ~/^\// - ~/$\// 
    def folderArray = folder.split('/')
    def parent = null
    if ( folderArray.size() > 1 ) {
      parent = folderArray[0..-2].join('/')
    }
    return parent
  }

  String getLeafFolder(String folder) {
    folder = folder - ~/^\// - ~/$\// 
    return folder.split('/').last()
  }

  void getAllFolders() {
    def folderItems = Jenkins.instance.getAllItems(Folder.class).each { item ->
      //AbstractFolder < ? > folderAbs1 = AbstractFolder.class.cast(item)
      out.println(item.getItemGroup().getFullName())
    }
  }

  void getFolder(String folder) {
    util.requirePlugin('cloudbees-folder')
    if ( folderExists(folder) ) {
      out.println(folder)
    }
  }

  void setFolder(String folder) {
    util.requirePlugin("cloudbees-folder")
    def j = Jenkins.get()

    if ( folderExists(folder) ) {
      return
    }

    def parent = getParentFolders(folder)
    def leaf = getLeafFolder(folder)
    if ( parent && ! folderExists(parent) ) {
      throw new Exception("Error: parent folder(s) does not exits : ${parent}")
    }
    j.checkGoodName(leaf)

    def target = j
    if ( parent ) {
      target = j.getItemByFullName(parent, Folder.class)
    }
    target.createProject(Folder.class, leaf)
    target.save()
  }

  void inSyncFolder(String folder) {
    def result = folderExists(folder) ? 'inSync' : 'OutSync'
    out.println(result) 
  }

  void removeFolder(
    String folder, 
    String force = false
  ) {
    def j = Jenkins.get()

    if ( ! folderExists(folder) ) {
      return
    }

    def victim = j.getItemByFullName(folder)
    def empty = victim.getItems() ? false : true
    if ( empty || force.toBoolean() ) {
      victim.delete()
      j.save()
    } 
    if ( !empty && !force.toBoolean() ) {
      throw new Exception("Error: Not removing folder ${folder} since it is not empty.  Use force=true to remove folder and all containing items")
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
