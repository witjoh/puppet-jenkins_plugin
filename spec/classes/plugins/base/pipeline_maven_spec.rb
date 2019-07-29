require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::pipeline_maven' do
  it do
    is_expected.to contain_jenkins__plugin('pipeline-maven').with_version(/\d.*/)
  end
end
