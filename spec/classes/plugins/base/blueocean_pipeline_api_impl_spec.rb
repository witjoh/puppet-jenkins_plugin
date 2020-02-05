require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::blueocean_pipeline_api_impl' do
  it do
    is_expected.to contain_jenkins__plugin('blueocean-pipeline-api-impl').with_version(%r{\d.*})
  end
end
