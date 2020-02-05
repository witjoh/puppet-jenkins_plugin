require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::ws_cleanup' do
  it do
    is_expected.to contain_jenkins__plugin('ws-cleanup').with_version(%r{\d.*})
  end
end
