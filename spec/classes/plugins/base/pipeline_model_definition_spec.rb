require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::pipeline_model_definition' do
  it do
    is_expected.to contain_jenkins__plugin('pipeline-model-definition').with_version(%r{\d.*})
  end
end
