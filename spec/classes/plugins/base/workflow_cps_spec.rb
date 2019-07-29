require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::workflow_cps' do
  it do
    is_expected.to contain_jenkins__plugin('workflow-cps').with_version(/\d.*/)
  end
end
