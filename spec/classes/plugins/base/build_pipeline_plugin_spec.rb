require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::build_pipeline_plugin' do
  it do
    is_expected.to contain_jenkins__plugin('build-pipeline-plugin').with_version(%r{\d.*})
  end
end
