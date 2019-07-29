require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::build_failure_analyzer' do
  it do
    is_expected.to contain_jenkins__plugin('build-failure-analyzer').with_version(/\d.*/)
  end
end
