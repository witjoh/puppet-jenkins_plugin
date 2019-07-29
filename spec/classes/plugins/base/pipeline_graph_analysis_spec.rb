require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::pipeline_graph_analysis' do
  it do
    is_expected.to contain_jenkins__plugin('pipeline-graph-analysis').with_version(/\d.*/)
  end
end
