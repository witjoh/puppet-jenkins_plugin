require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::sse_gateway' do
  it do
    is_expected.to contain_jenkins__plugin('sse-gateway').with_version(%r{\d.*})
  end
end
