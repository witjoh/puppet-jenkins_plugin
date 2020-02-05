require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::rebuild' do
  it do
    is_expected.to contain_jenkins__plugin('rebuild').with_version(%r{\d.*})
  end
end
