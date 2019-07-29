require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::greenballs' do
  it do
    is_expected.to contain_jenkins__plugin('greenballs').with_version(/\d.*/)
  end
end
