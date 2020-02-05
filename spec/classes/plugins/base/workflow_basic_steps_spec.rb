require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::workflow_basic_steps' do
  it do
    is_expected.to contain_jenkins__plugin('workflow-basic-steps').with_version(%r{\d.*})
  end
end
