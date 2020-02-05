require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::pipeline_model_api' do
  it do
    is_expected.to contain_jenkins__plugin('pipeline-model-api').with_version(%r{\d.*})
  end
end
