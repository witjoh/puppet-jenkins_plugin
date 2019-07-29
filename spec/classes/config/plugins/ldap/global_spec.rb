require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::config::plugins::ldap::global' do

  context 'default params' do

    arglist = 'disableroleprefixing:false disablemailaddressresolver:false useridstrategy:CaseInsensitive groupidstrategy:CaseInsensitive'

    it do
      is_expected.to contain_jenkins__cli__exec('ldap_set_settings').with(
        command: "ldap_set_settings #{arglist}",
        unless: "[[ $($HELPER_CMD ldap_insync_settings \"#{arglist}\") = true ]]",
        plugin: 'ldap',
      )
    end
  end

  context 'custom params' do

    let(:params) do
      {
        disableroleprefixing: true,
        disablemailaddressresolver: true,
        useridstrategy: "CaseSensitive",
        groupidstrategy: '1',
        cachesize: 20,
        cachettl: 20,
      }
    end

    arglist = 'disableroleprefixing:true disablemailaddressresolver:true useridstrategy:CaseSensitive groupidstrategy:1 cachesize:20 cachettl:20'

    it do
      is_expected.to contain_jenkins__cli__exec('ldap_set_settings').with(
        command: "ldap_set_settings #{arglist}",
        unless: "[[ $($HELPER_CMD ldap_insync_settings \"#{arglist}\") = true ]]",
        plugin: 'ldap',
      )
    end
  end
end
