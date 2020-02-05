require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::cloudbees_bitbucket_branch_source' do
  it do
    is_expected.to contain_jenkins__plugin('cloudbees-bitbucket-branch-source').with_version(%r{\d.*})
  end
end
