require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::workflow_support' do
  it do
    is_expected.to contain_jenkins__plugin('workflow-support').with_version(%r{\d.*})
  end
end
