require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::favorite' do
  it do
    is_expected.to contain_jenkins__plugin('favorite').with_version(/\d.*/)
  end
end
