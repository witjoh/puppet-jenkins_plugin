require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::maven_repo_cleaner' do
  it do
    is_expected.to contain_jenkins__plugin('maven-repo-cleaner').with_version(/\d.*/)
  end
end
