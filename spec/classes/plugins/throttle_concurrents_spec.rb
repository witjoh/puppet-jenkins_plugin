require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::throttle_concurrents' do
  [
    'throttle-concurrents',
    'workflow-api',
    'workflow-durable-task-step',
    'workflow-step-api',
    'workflow-support',
    'matrix-project',
  ].each do | name |
    it do
      is_expected.to contain_jenkins__plugin(name).with_version(/\d.*/)
    end
  end  
end
