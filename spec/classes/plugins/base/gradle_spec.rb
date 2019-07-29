require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::gradle' do
  it do
    is_expected.to contain_jenkins__plugin('gradle').with_version(/\d.*/)
  end
end
