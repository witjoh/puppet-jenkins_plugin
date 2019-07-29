require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::workflow_scm_step' do
  it do
    is_expected.to contain_jenkins__plugin('workflow-scm-step').with_version(/\d.*/)
  end
end
