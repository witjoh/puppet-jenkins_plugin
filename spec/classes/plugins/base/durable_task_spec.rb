require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::durable_task' do
  it do
    is_expected.to contain_jenkins__plugin('durable-task').with_version(/\d.*/)
  end
end
