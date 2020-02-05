require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::jdk_tool' do
  it do
    is_expected.to contain_jenkins__plugin('jdk-tool').with_version(%r{\d.*})
  end
end
