require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::jsch' do
  it do
    is_expected.to contain_jenkins__plugin('jsch').with_version(/\d.*/)
  end
end
