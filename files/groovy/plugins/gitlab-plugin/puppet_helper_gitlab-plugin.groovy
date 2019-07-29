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

import jenkins.model.*
import com.cloudbees.plugins.credentials.*
import com.cloudbees.plugins.credentials.common.*
import com.cloudbees.plugins.credentials.domains.*
import com.cloudbees.plugins.credentials.impl.*
import com.dabsquared.gitlabjenkins.connection.*
import hudson.util.Secret

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

  /////////////////////////
  // Gitlab plugin
  /////////////////////////

  /////////////////////////
  // Gitlab Global Config
  /////////////////////////

  void gitlab_get_global() {
    def j = Jenkins.getInstance()
    def glc = j.getDescriptor(GitLabConnectionConfig.class)

    out.println(glc.isUseAuthenticatedEndpoint().toString())
  }

  void gitlab_set_global(
    String useAuthenticatedEndpoint = 'true') {
    def j = Jenkins.getInstance()
    def glc = j.getDescriptor(GitLabConnectionConfig.class)
    def filtered = ['class', 'active']

    glc.useAuthenticatedEndpoint = useAuthenticatedEndpoint.toBoolean()

    glc.save()
  }

  void gitlab_insync_global(
    String useAuthenticatedEndpoint) {
    def j = Jenkins.getInstance()
    def glc = j.getDescriptor(GitLabConnectionConfig.class)

    out.println(glc.isUseAuthenticatedEndpoint() == useAuthenticatedEndpoint.toBoolean())
  }
  /////////////////////////
  // Gitlab connection
  /////////////////////////

  /////////////////////////
  // Gitlab Connextion helper functions
  /////////////////////////

  GitLabConnection getGitlabConnectionByName (
    String name ) {
    def j = Jenkins.getInstance()
    def glc = j.getDescriptor(GitLabConnectionConfig.class)
    def result = null

    glc.getConnections().each {
      if ( it.getName() == name ) {
        result = it
      }
    }
    return result
  }

  Integer getGitlabConnectionIndex(String name) {
    def j = Jenkins.getInstance()
    def glc = j.getDescriptor(GitLabConnectionConfig.class)
    def result = null

    glc.getConnections().eachWithIndex { item, index ->
      if ( item.getName() == name ) {
        result = index
      }
    }
    return result
  }

  String apiLevelToString(String apiLevel) {
    def result
    switch (apiLevel) {
      case 'autodetect':
      case 'v3':
      case 'v4':
        result = apiLevel
        break
      case '0':
        result = 'autodetect'
        break
      case '1':
        result = 'v4'
        break
      case '2':
        result = 'v3'
        break
      default:
        result = 'autodetect'
    }
    return result
  }

  LinkedHashMap gitlabConnectionToMap(GitLabConnection connection) {
    def map = [:]
    if (connection) {
      map << [ name: connection.getName() ]
      map << [ apitokenid: connection.getApiTokenId() ]
      map << [ url: connection.getUrl() ]
      map << [ clientbuilderid: connection.clientBuilderId ]
      map << [ ignorecertificteerrors: connection.isIgnoreCertificateErrors() ]
      map << [ connectiontimeout: connection.getConnectionTimeout() ]
      map << [ readtimeout: connection.getReadTimeout() ]

      map = util.mapRemoveAllNull(map)
    }
    return map
  }

  GitLabConnection mapToGitlabConnection(LinkedHashMap map) {
    def conn = null
    if (map) {
      conn = new GitLabConnection(
        map.name,
        map.url,
        map.apitokenid,
        apiLevelToString(map.clientbuilderid),
        map.ignorecertificaterrrors ? map.ignorecertificaterrrors.toBoolean() : false,
        map.connectiontimeout ? map.connectiontimeout.toInteger() : 10,
        map.readtimeout ? map.readtimeout.toInteger() : 10
      )
    }
    return conn
  }

  //////////////////////
  // End Gitlab Connection Helper Functions
  //////////////////////

  void gitlab_get_connection(
    String name) {
    util.requirePlugin('gitlab-plugin')

    def conn = gitlabConnectionToMap(getGitlabConnectionByName(name))
    util.printMap(conn)
  }

  void gitlab_set_connection(String... arguments) {
    util.requirePlugin('gitlab-plugin')
    def map = util.argsToMap(arguments)
    def srv = mapToGitlabConnection(map)

    def index = getGitlabConnectionIndex(map.name)

    def j = Jenkins.getInstance()
    def glc = j.getDescriptor(GitLabConnectionConfig.class)

    if ( index >= 0 ) {
      def conn = glc.getConnections()
      conn[index] = srv
      glc.setConnections(conn)
    } else {
      glc.addConnection(srv)
    }
  }

  void gitlab_del_connection(
    String name) {
    util.requirePlugin('gitlab-plugin')
    def j = Jenkins.getInstance()
    def glc = j.getDescriptor(GitLabConnectionConfig.class)

    def index = getGitlabConnectionIndex(name)

    if ( index >= 0 ) {
      def conn = glc.getConnections()
      conn.removeAt(index)
      glc.setConnections(conn)
    }
  }

  void gitlab_insync_connection(String... arguments) {
    util.requirePlugin('gitlab-plugin')
    def mapShould = mapToGitlabConnection(util.argsToMap(arguments))
    mapShould = gitlabConnectionToMap(mapShould)

    def mapIs = gitlabConnectionToMap(getGitlabConnectionByName(mapShould.name))

    out.println(mapShould.equals(mapIs))
  }

  /////////////////////////
  // Gitlab Token
  /////////////////////////

  //////////////////////////
  // gitlab token helper functions
  /////////////////////////

  LinkedHashMap gitlabApiTokenToMap(GitLabApiTokenImpl token) {
    def map = [:]
    if (token) {
      map << [ id: token.getId() ]
      map << [ description: token.getDescription() ]
      map << [ scope: token.getScope().toString() ]
      map << [ apitoken: token.getApiToken().getPlainText() ]
    }
    return map
  }

  CredentialsScope scopeToObject(String scope) {
    def res = null
    switch (scope ? scope.toUpperCase(): scope) {
      case 'GLOBAL':
        res = CredentialsScope.GLOBAL
        break
      case 'SYSTEM':
        res = CredentialsScope.SYSTEM
        break
      case 'USER':
        res = CredentialsScope.USER
        break
      default:
        res = CredentialsScope.GLOBAL
    }
    return res
  }
    
  GitLabApiTokenImpl mapToGitlabApiToken (LinkedHashMap map) {
    def token = null
    if (map) {
      token = new GitLabApiTokenImpl(
        scopeToObject(map.scope),
        map.id,
        map.description,
        hudson.util.Secret.fromString(map.apitoken)
      )
    }
    return token
  }

  GitLabApiTokenImpl getGitlabTokenById(String id) {
    // lookup the Apitoken by ID, return null if not found
    util.requirePlugin('gitlab-plugin')
    def scp = SystemCredentialsProvider.getInstance()
    def result = null
    scp.getCredentials().each {
      if ( it.getClass().getName() == "com.dabsquared.gitlabjenkins.connection.GitLabApiTokenImpl" ) {
        // we found a gitlabtoken
        if ( it.getId() == id ) {
          result = it
        }
      }
    }
    return result
  }

  ///////////////////////
  // End helper methods
  ///////////////////////

  void gitlab_get_token(
    String id) {
    util.requirePlugin('gitlab-plugin')

    def token = gitlabApiTokenToMap(getGitlabTokenById(id))
    util.printMap(token)
  }

  // jenkins will add the token whenever the id does not exists.
  // as soon ad this exists, this becomes a read-only object.
  // only way to update a token is to remove it and then recreate
  // nevertheless, updating works in the gui so we need to check
  // of we need to update some fields only ....

  void gitlab_set_token(String... arguments) {
    util.requirePlugin('gitlab-plugin')

    def apiToken = mapToGitlabApiToken(util.argsToMap(arguments))
    def domain = Domain.global()

    def scp = SystemCredentialsProvider.getInstance()

    def tempToken = getGitlabTokenById(apiToken.getId())

    if ( tempToken ) {
      scp.updateCredentials(domain, tempToken, apiToken)
    } else {
      scp.addCredentials(domain, apiToken)
    }
    scp.save()
  }

  void gitlab_del_token(
    String id) {
    util.requirePlugin('gitlab-plugin')

    def token = getGitlabTokenById(id)
    if ( token) {
      def domain = Domain.global()
      def scp = SystemCredentialsProvider.getInstance()
      scp.removeCredentials(domain, token)
      scp.save()
    }
  }

  void gitlab_insync_token(String... arguments) {
    util.requirePlugin('gitlab-plugin')
    def mapShould = gitlabApiTokenToMap(mapToGitlabApiToken(util.argsToMap(arguments)))
    def mapIs = gitlabApiTokenToMap(getGitlabTokenById(mapShould.id))

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
