require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::github_branch_source' do
  it do
    is_expected.to contain_jenkins__plugin('github-branch-source').with_version(/\d.*/)
  end
end
