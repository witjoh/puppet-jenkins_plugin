require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::github' do
  it do
    is_expected.to contain_jenkins__plugin('github').with_version(%r{\d.*})
  end
end
