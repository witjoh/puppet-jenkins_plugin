require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::config::plugins::gitlab::global' do
  context 'default params' do
    it do
      is_expected.to contain_jenkins__cli__exec('gitlab_set_global').with(
        command: 'gitlab_set_global true',
        unless: '[ $($HELPER_CMD gitlab_insync_global true) = true ]',
        plugin: 'gitlab-plugin',
      )
    end
  end

  context 'use_authenticated_endpoint => false' do
    let(:params) do
      {
        use_authenticated_endpoint: false,
      }
    end
    it do
      is_expected.to contain_jenkins__cli__exec('gitlab_set_global').with(
        command: 'gitlab_set_global false',
        unless: '[ $($HELPER_CMD gitlab_insync_global false) = true ]',
        plugin: 'gitlab-plugin',
      )
    end
  end
end
