require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::junit' do
  it do
    is_expected.to contain_jenkins__plugin('junit').with_version(%r{\d.*})
  end
end
