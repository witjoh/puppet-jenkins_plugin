require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::workflow_api' do
  it do
    is_expected.to contain_jenkins__plugin('workflow-api').with_version(%r{\d.*})
  end
end
