require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::config::plugins::ldap::server' do

  let(:title) { 'ldap://ldap.example.com' }

  context 'default params' do

    # below is a list of the resource parameters that you can override.
    # By default all non-required parameters are commented out,
    # while all required parameters will require you to add a value
    let(:params) do
      {
        managerdn: 'ou=user',
        managerpassword: 'password',
      }
    end

    arglist = "server:ldap://ldap.example.com managerdn:ou=user managerpassword:'password' usersearch:uid={0} inhibitinferrootdn:false displaynameattributename:displayname mailaddressattributename:mail"

    it do
      is_expected.to contain_jenkins__cli__exec('ldap_set_server-ldap://ldap.example.com').with(
        command: "ldap_set_server #{arglist}",
        unless: "[ $($HELPER_CMD ldap_insync_server \"#{arglist}\") = true ]",
        plugin: 'ldap',
      )
    end
  end

  context 'custom params' do

    # below is a list of the resource parameters that you can override.
    # By default all non-required parameters are commented out,
    # while all required parameters will require you to add a value
    let(:params) do
      {
        managerdn: 'ou=user',
        managerpassword: 'password',
        server: 'ldaps://override.example.com',
        usersearch: 'o={0}',
        inhibitinferrootdn: true,
        displaynameattributename: 'fullname',
        mailaddressattributename: 'othermail',
        rootdn: 'rootdn',
        usersearchbase: 'newbase',
        groupsearchbase: 'search',
        groupsearchfilter: 'groupsearch',
      }
    end

    arglist = "server:ldaps://override.example.com managerdn:ou=user managerpassword:'password' usersearch:o={0} inhibitinferrootdn:true displaynameattributename:fullname mailaddressattributename:othermail rootdn:rootdn usersearchbase:newbase groupsearchbase:search groupsearchfilter:groupsearch"

    it do
      is_expected.to contain_jenkins__cli__exec('ldap_set_server-ldap://ldap.example.com').with(
        command: "ldap_set_server #{arglist}",
        unless: "[ $($HELPER_CMD ldap_insync_server \"#{arglist}\") = true ]",
        plugin: 'ldap',
      )
    end
  end

  context 'ensure => absent' do
    let(:params) do
      {
        managerdn: 'ou=user',
        managerpassword: 'password',
        ensure: 'absent',
      }
    end

    it do
      is_expected.to contain_jenkins__cli__exec('ldap_del_server-ldap://ldap.example.com').with(
        command: 'ldap_del_server ldap://ldap.example.com',
        unless: "[[ -z \$(\$HELPER_CMD ldap_get_server ldap://ldap.example.com | grep ldap://ldap.example.com) ]]",
        plugin: 'ldap',
      )    
    end
  end
end
