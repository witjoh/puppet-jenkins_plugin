require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::workflow_durable_task_step' do
  it do
    is_expected.to contain_jenkins__plugin('workflow-durable-task-step').with_version(%r{\d.*})
  end
end
