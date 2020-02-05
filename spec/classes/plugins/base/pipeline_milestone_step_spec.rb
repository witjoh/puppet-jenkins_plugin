require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::pipeline_milestone_step' do
  it do
    is_expected.to contain_jenkins__plugin('pipeline-milestone-step').with_version(%r{\d.*})
  end
end
