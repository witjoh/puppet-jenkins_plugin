require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::build_failure_analyzer' do
  [
    'build-failure-analyzer',
    'junit',
    'apache-httpcomponents-client-4-api',
    'jackson2-api',
    'matrix-project',
  ].each do |name|
    it do
      is_expected.to contain_jenkins__plugin(name).with_version(%r{\d.*})
    end
  end
end
