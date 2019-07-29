require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::command_launcher' do
  it do
    is_expected.to contain_jenkins__plugin('command-launcher').with_version(/\d.*/)
  end
end
