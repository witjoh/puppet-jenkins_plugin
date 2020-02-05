require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::run_condition' do
  it do
    is_expected.to contain_jenkins__plugin('run-condition').with_version(%r{\d.*})
  end
end
