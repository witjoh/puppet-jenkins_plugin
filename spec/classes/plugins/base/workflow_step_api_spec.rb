require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::workflow_step_api' do
  it do
    is_expected.to contain_jenkins__plugin('workflow-step-api').with_version(/\d.*/)
  end
end
