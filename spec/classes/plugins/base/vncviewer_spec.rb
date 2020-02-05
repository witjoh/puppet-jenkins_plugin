require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::vncviewer' do
  it do
    is_expected.to contain_jenkins__plugin('vncviewer').with_version(%r{\d.*})
  end
end
