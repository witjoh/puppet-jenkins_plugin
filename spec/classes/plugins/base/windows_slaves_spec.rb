require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::windows_slaves' do
  it do
    is_expected.to contain_jenkins__plugin('windows-slaves').with_version(%r{\d.*})
  end
end
