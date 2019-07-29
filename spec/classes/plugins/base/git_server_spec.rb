require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::git_server' do
  it do
    is_expected.to contain_jenkins__plugin('git-server').with_version(/\d.*/)
  end
end
