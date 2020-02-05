require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::blueocean_git_pipeline' do
  it do
    is_expected.to contain_jenkins__plugin('blueocean-git-pipeline').with_version(%r{\d.*})
  end
end
