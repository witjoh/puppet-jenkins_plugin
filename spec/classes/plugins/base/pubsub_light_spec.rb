require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::pubsub_light' do
  it do
    is_expected.to contain_jenkins__plugin('pubsub-light').with_version(%r{\d.*})
  end
end
