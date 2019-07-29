require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::git_client' do
  it do
    is_expected.to contain_jenkins__plugin('git-client').with_version(/\d.*/)
  end
end
