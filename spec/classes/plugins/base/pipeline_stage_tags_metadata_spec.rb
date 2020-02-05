require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::pipeline_stage_tags_metadata' do
  it do
    is_expected.to contain_jenkins__plugin('pipeline-stage-tags-metadata').with_version(%r{\d.*})
  end
end
