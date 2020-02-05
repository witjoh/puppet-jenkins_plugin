require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::config::plugins::gitlab::token' do
  let(:title) { 'foo' }

  context 'default params' do
    let(:params) do
      {
        apitoken: 'token',
      }
    end

    it do
      is_expected.to contain_jenkins__cli__exec('gitlab_set_token-foo').with(
        command: "gitlab_set_token id:'foo' apitoken:'token' description:'Api Token for Gitlab'",
        unless: "[[ $($HELPER_CMD gitlab_insync_token \"id:'foo' apitoken:'token' description:'Api Token for Gitlab'\") == true ]]",
        plugin: 'gitlab-plugin',
      )
    end
  end

  context 'custom parameters' do
    let(:params) do
      {
        apitoken: 'token',
        id: 'newfoo',
        ensure: 'present',
        description: 'newdescription',
      }
    end

    it do
      is_expected.to contain_jenkins__cli__exec('gitlab_set_token-foo').with(
        command: "gitlab_set_token id:'newfoo' apitoken:'token' description:'newdescription'",
        unless: "[[ $($HELPER_CMD gitlab_insync_token \"id:'newfoo' apitoken:'token' description:'newdescription'\") == true ]]",
        plugin: 'gitlab-plugin',
      )
    end
  end

  context 'ensure => absent' do
    let(:params) do
      {
        apitoken: 'token',
        ensure: 'absent',
      }
    end

    it do
      is_expected.to contain_jenkins__cli__exec('gitlab_del_token-foo').with(
        command: "gitlab_del_token 'foo'",
        unless: "[[ -z $($HELPER_CMD gitlab_get_token 'foo' | /bin/awk '{ print $1}') ]]",
        plugin: 'gitlab-plugin',
      )
    end
  end
end
