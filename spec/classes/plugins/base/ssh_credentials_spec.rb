require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::ssh_credentials' do
  it do
    is_expected.to contain_jenkins__plugin('ssh-credentials').with_version(%r{\d.*})
  end
end
