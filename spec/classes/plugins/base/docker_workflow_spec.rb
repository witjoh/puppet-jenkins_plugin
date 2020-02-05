require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::docker_workflow' do
  it do
    is_expected.to contain_jenkins__plugin('docker-workflow').with_version(%r{\d.*})
  end
end
