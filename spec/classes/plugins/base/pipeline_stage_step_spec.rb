require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::pipeline_stage_step' do
  it do
    is_expected.to contain_jenkins__plugin('pipeline-stage-step').with_version(/\d.*/)
  end
end
