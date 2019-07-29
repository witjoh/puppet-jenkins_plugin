require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::metrics_graphite' do
  it do
    is_expected.to contain_jenkins__plugin('metrics-graphite').with_version(/\d.*/)
  end
end
