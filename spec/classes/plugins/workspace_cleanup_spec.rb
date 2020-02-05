require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::workspace_cleanup' do
  [
    'ws-cleanup',
    'workflow-durable-task-step',
    'matrix-project',
    'resource-disposer',
    'script-security',
  ].each do |name|
    it do
      is_expected.to contain_jenkins__plugin(name).with_version(%r{\d.*})
    end
  end
end
