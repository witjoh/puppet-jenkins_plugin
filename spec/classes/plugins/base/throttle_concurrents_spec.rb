require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::throttle_concurrents' do
  it do
    is_expected.to contain_jenkins__plugin('throttle-concurrents').with_version(%r{\d.*})
  end
end
