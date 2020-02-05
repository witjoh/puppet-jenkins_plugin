require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::blueocean_github_pipeline' do
  it do
    is_expected.to contain_jenkins__plugin('blueocean-github-pipeline').with_version(%r{\d.*})
  end
end
