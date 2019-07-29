require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::pipeline_build_step' do
  it do
    is_expected.to contain_jenkins__plugin('pipeline-build-step').with_version(/\d.*/)
  end
end
