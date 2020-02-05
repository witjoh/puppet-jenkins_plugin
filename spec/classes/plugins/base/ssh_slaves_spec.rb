require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::ssh_slaves' do
  it do
    is_expected.to contain_jenkins__plugin('ssh-slaves').with_version(%r{\d.*})
  end
end
