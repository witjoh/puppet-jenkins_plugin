require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::docker_commons' do
  it do
    is_expected.to contain_jenkins__plugin('docker-commons').with_version(%r{\d.*})
  end
end
