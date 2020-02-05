require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::workflow_cps_global_lib' do
  it do
    is_expected.to contain_jenkins__plugin('workflow-cps-global-lib').with_version(%r{\d.*})
  end
end
