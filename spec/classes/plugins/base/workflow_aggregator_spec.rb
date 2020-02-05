require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::workflow_aggregator' do
  it do
    is_expected.to contain_jenkins__plugin('workflow-aggregator').with_version(%r{\d.*})
  end
end
