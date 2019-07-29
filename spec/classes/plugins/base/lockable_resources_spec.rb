require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::lockable_resources' do
  it do
    is_expected.to contain_jenkins__plugin('lockable-resources').with_version(/\d.*/)
  end
end
