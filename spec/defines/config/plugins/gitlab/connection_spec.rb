require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::config::plugins::gitlab::connection' do

  let(:title) { 'foo' }

  context 'default params' do
    let(:params) do
      {
        url: 'http://myhost',
        apitokenid: 'mytoken',
      }
    end

    it do
      is_expected.to contain_jenkins__cli__exec('gitlab_set_connection-foo').with(
        command: "gitlab_set_connection name:'foo' apitokenid:'mytoken' url:http://myhost clientbuilderid:autodetect",
        unless: "[ $($HELPER_CMD gitlab_insync_connection name:'foo' apitokenid:'mytoken' url:http://myhost clientbuilderid:autodetect) = true ]",
        plugin: 'gitlab-plugin',
      )
    end
  end

  context 'custom parameters' do
    let(:params) do
      {
        url: 'http://newhost',
        apitokenid: 'newtoken',
        ensure: "present",
        connectionname: "newfoo",
        clientbuilderid: "v4",
        connectiontimeout: 20,
        readtimeout: 20,
      }
    end

    it do
      is_expected.to contain_jenkins__cli__exec('gitlab_set_connection-foo').with(
        command: "gitlab_set_connection name:'newfoo' apitokenid:'newtoken' url:http://newhost clientbuilderid:v4 connectiontimout:20 readtimeout:20",
        unless: "[ $($HELPER_CMD gitlab_insync_connection name:'newfoo' apitokenid:'newtoken' url:http://newhost clientbuilderid:v4 connectiontimout:20 readtimeout:20) = true ]",
        plugin: 'gitlab-plugin',
      )
    end
  end

  context 'ensure => absent' do
    let(:params) do
      {
        url: 'http://newhost',
        apitokenid: 'newtoken',
        ensure: "absent",
      }
    end
    it do
      is_expected.to contain_jenkins__cli__exec('gitlab_del_connection-foo').with(
        command: "gitlab_del_connection 'foo'",
        unless: "[[ -z $($HELPER_CMD gitlab_get_connection 'foo' | /bin/awk '{ print $1}') ]]",
        plugin: 'gitlab-plugin',
      )
    end
  end
end
