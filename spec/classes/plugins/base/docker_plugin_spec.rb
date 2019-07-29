require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::docker_plugin' do
  
  it do
    is_expected.to contain_jenkins__plugin('docker-plugin').with_version(/\d.*/)
  end
end
