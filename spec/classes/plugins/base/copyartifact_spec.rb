require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::copyartifact' do
  it do
    is_expected.to contain_jenkins__plugin('copyartifact').with_version(/\d.*/)
  end
end
