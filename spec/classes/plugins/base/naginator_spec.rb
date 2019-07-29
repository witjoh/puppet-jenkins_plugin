require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::naginator' do
  it do
    is_expected.to contain_jenkins__plugin('naginator').with_version(/\d.*/)
  end
end
