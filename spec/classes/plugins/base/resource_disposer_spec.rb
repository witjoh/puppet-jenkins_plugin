require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::resource_disposer' do
  it do
    is_expected.to contain_jenkins__plugin('resource-disposer').with_version(%r{\d.*})
  end
end
