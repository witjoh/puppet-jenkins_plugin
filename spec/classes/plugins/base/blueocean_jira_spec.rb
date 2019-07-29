require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::blueocean_jira' do
  it do
    is_expected.to contain_jenkins__plugin('blueocean-jira').with_version(/\d.*/)
  end
end
