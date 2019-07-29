require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::parameterized_trigger' do
  it do
    is_expected.to contain_jenkins__plugin('parameterized-trigger').with_version(/\d.*/)
  end
end
