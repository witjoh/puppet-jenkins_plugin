require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::structs' do
  it do
    is_expected.to contain_jenkins__plugin('structs').with_version(/\d.*/)
  end
end
