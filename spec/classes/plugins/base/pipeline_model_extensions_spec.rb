require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::pipeline_model_extensions' do
  it do
    is_expected.to contain_jenkins__plugin('pipeline-model-extensions').with_version(/\d.*/)
  end
end
