require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::pipeline_stage_view' do
  it do
    is_expected.to contain_jenkins__plugin('pipeline-stage-view').with_version(%r{\d.*})
  end
end
