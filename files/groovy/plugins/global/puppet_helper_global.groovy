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

import com.cloudbees.jenkins.plugins.sshcredentials.impl.*
import com.cloudbees.plugins.credentials.*
import com.cloudbees.plugins.credentials.common.*
import com.cloudbees.plugins.credentials.domains.*
import com.cloudbees.plugins.credentials.impl.*
import groovy.transform.InheritConstructors
import hudson.model.*
import hudson.plugins.sshslaves.*
import hudson.util.*
import hudson.security.*
import jenkins.model.*
import jenkins.security.*
import org.apache.commons.io.IOUtils
import org.jenkinsci.plugins.*
import jenkins.security.plugins.ldap.*
//import org.jenkinsci.main.modules.sshd
import jenkins.security.s2m.AdminWhitelistRule
import hudson.security.csrf.DefaultCrumbIssuer
import hudson.slaves.EnvironmentVariablesNodeProperty


class InvalidAuthenticationStrategy extends Exception{}
@InheritConstructors
class UnsupportedCredentialsClass extends Exception {}
@InheritConstructors
class InvalidCredentialsId extends Exception {}
@InheritConstructors
class MissingRequiredPlugin extends Exception {}

///////////////////////////////////////////////////////////////////////////////
// Util
///////////////////////////////////////////////////////////////////////////////

// Private methods don't appear to be "private" under groovy.  This utility
// class is for methods that should not be exposed as CLI options via the
// Action class.
class Util {
  Util(out) { this.out = out }
  def out

  def requirePlugin(String plugin) {
    def j = Jenkins.getInstance()

    if (! j.getPlugin(plugin)) {
      throw new MissingRequiredPlugin(plugin)
    }
  }
} // class Util

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

  String nullStringCheck(String v) {

    switch (v) {
      case '':
      case 'null':
      case 'undef':
        return null
        break
      default:
        return v
        break
    }
  }


  /////////////////////////
  // get system message
  /////////////////////////

  void get_system_message() {
    def j = Jenkins.getInstance()
    def message = j.systemMessage
    out.println(message)
  }

  /////////////////////////
  // create or update System Message
  /////////////////////////

  void set_system_message(String message) {
    message =  nullStringCheck(message)
    def j = Jenkins.getInstance()
    j.systemMessage = message
    j.save()
  }

  /////////////////////////
  // get admin email
  /////////////////////////

  void get_admin_email() {
    def jlc = new JenkinsLocationConfiguration().get()
    def email= jlc.getAdminAddress()
    if ( email == 'address not configured yet <nobody@nowhere>' ) {
      email = null
    }
    out.println(email)
  }


  /////////////////////////
  // create or update admin email
  /////////////////////////

  void set_admin_email(String email) {
    email =  nullStringCheck(email)
    def jlc = new JenkinsLocationConfiguration().get()
    jlc.setAdminAddress(email)
    jlc.save()
  }

  /////////////////////////
  // get jenkins URL
  /////////////////////////

  void get_jenkins_url() {
    def jlc = new JenkinsLocationConfiguration().get()
    def url = jlc.getUrl()
    out.println(url)
  }

  /////////////////////////
  // create or update jenkins URL
  /////////////////////////

  void set_jenkins_url(String url) {
    url =  nullStringCheck(url)
    def jlc = new JenkinsLocationConfiguration().get()
    jlc.setUrl(url)
    jlc.save()
  }

  /////////////////////////
  // get master labels
  ////////////////////////

  void get_master_labels() {
    def j = Jenkins.getInstance()
    def labels = j.getLabelString()
    if (labels == '') {
      labels = 'null'
    }
    out.println(labels)
  }

  /////////////////////////
  // create or update master labels
  /////////////////////////

  void set_master_labels(String... args) {
    def label = args.join(' ')
    label = nullStringCheck(label)
    def j = Jenkins.getInstance()
    j.setLabelString(label)
    j.save()
  }

  /////////////////////////
  // Global_security misc settings
  /////////////////////////

  void set_master_usage(String use='NORMAL') {
    // 2 modes : NORMAL and EXCLUSIVE
    // When not EXCLUSIVE, we reset to the default -> NORMAL

    if ( use.toUpperCase() != 'EXCLUSIVE' ) {
      use = 'NORMAL'
    } else {
      use = 'EXCLUSIVE'
    }

    def j = Jenkins.getInstance()
    j.setMode(Node.Mode."${use}")
    j.save()
  }

  void get_master_usage() {
    def j = Jenkins.getInstance()
    out.println(j.getMode().getName())
  }

  void set_crumb_issuer(
    String enable = false,
    String exclude_client_IP = false) {

    def j = Jenkins.getInstance()
    if ( enable.toBoolean() ) {
      j.crumbIssuer =(new DefaultCrumbIssuer(exclude_client_IP.toBoolean()))
    } else {
      j.crumbIssuer = null
    }
    j.save()
  }

  void get_crumb_issuer() {
    def j = Jenkins.getInstance()
    def gc = j.crumbIssuer

    if (  gc ) {
      out.println('on')
    } else {
      out.println('off')
    }
  }

  // remoting removed as of 2.165 : https://jenkins.io/blog/2019/02/17/remoting-cli-removed/
  void set_cli_remoting(
    String enable = false) {
    if ( Jenkins.VERSION.split(/\./)[1].toInteger() < '2.165'.split(/\./)[1].toInteger() ) {
      def j = Jenkins.getInstance()
      j.getDescriptor("jenkins.CLI").get().setEnabled(enable.toBoolean())
      j.save()
    }
  }

  void get_cli_remoting() {
    if ( Jenkins.VERSION.split(/\./)[1].toInteger() < '2.165'.split(/\./)[1].toInteger() ) {
      def j = Jenkins.getInstance()

      if ( j.getDescriptor("jenkins.CLI").get().isEnabled() ) {
        out.println('on')
      } else {
        out.println('off')
      }
    } else {
      out.println('removed')
    }
  }

  void set_agent_master_kill_switch(
    String enable = true) {

    def j = Jenkins.getInstance()
    j.getInjector().getInstance(AdminWhitelistRule.class).setMasterKillSwitch(enable.toBoolean())
    j.save()
  }

  void get_agent_master_kill_switch() {

    if ( Jenkins.instance.getInjector().getInstance(AdminWhitelistRule.class).getMasterKillSwitch() ) {
      // re verse logic here
      out.println('on')
    } else {
      out.println('off')
    }
  }

  void set_sshd_port(
    String port = '-1') {

    // -1 -> disables
    //  0 -> random
    // >0 -> Specific port

    def j = Jenkins.getInstance()
    def sshDesc = j.getDescriptor("org.jenkinsci.main.modules.sshd.SSHD")
    sshDesc.setPort(port.toInteger())
    j.save()
  }

  void get_sshd_port() {

    def j = Jenkins.getInstance()
    def sshDesc = j.getDescriptor("org.jenkinsci.main.modules.sshd.SSHD")
    out.println(sshDesc.getPort())
  }

  /////////////////////////
  // End misc global security stuff
  /////////////////////////

  void get_global_env( String key ) {
    def j = Jenkins.get()
    def globalNodeProperties = j.getGlobalNodeProperties()
    def envVarsNodePropertyList = globalNodeProperties.getAll(EnvironmentVariablesNodeProperty.class)

    if ( ! envVarsNodePropertyList.empty ) {
      def envVars = envVarsNodePropertyList.get(0).getEnvVars()
      def var = envVars.get(key, 'NotFound')
      if ( var != 'NotFound' ) {
        out.println(var)
      }
    }
  }

  void get_all_global_envs() {
    def j = Jenkins.get()
    def globalNodeProperties = j.getGlobalNodeProperties()
    def envVarsNodePropertyList = globalNodeProperties.getAll(EnvironmentVariablesNodeProperty.class)

    if ( ! envVarsNodePropertyList.empty ) {
      def envVars = envVarsNodePropertyList.get(0).getEnvVars()
      envVars.each{ k,v -> 
        out.println(k + '=' + v)
      }
    }
  }

  void set_global_env(
    String key,
    String value ) {

    def j = Jenkins.get()
    def globalNodeProperties = j.getGlobalNodeProperties()
    def envVarsNodePropertyList = globalNodeProperties.getAll(EnvironmentVariablesNodeProperty.class)
    def envVars = null

    if ( ! envVarsNodePropertyList.empty ) {
      envVars = envVarsNodePropertyList.get(0).getEnvVars()
      def var = envVars.get(key, 'NotFound')
      if ( var == 'NotFound' ) {
        envVars.putIfNotNull(key, value)
      } else {
        envVars.addLine("${key}=${value}")
      }
    } else {
      def newEnvVarsNodeProperty = new hudson.slaves.EnvironmentVariablesNodeProperty();
      globalNodeProperties.add(newEnvVarsNodeProperty)
      envVars = newEnvVarsNodeProperty.getEnvVars()
      envVars.addLine("${key}=${value}")
    }

    j.save()
  }

  void del_global_env ( String key) {
    def j = Jenkins.get()
    def globalNodeProperties = j.getGlobalNodeProperties()
    def envVarsNodePropertyList = globalNodeProperties.getAll(EnvironmentVariablesNodeProperty.class)

    if ( ! envVarsNodePropertyList.empty ) {
      def envVars = envVarsNodePropertyList.get(0).getEnvVars()
      def var = envVars.get(key, 'NotFound')
      if ( var != 'NotFound' ) {
        envVars.remove(key)
        j.save()
      }
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
