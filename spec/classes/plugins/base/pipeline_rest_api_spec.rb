require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::pipeline_rest_api' do
  it do
    is_expected.to contain_jenkins__plugin('pipeline-rest-api').with_version(/\d.*/)
  end
end
