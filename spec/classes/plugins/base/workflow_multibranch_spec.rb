require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::workflow_multibranch' do
  it do
    is_expected.to contain_jenkins__plugin('workflow-multibranch').with_version(%r{\d.*})
  end
end
