require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::publish_over_ssh' do
  [
    'publish-over-ssh',
    'jsch',
    'publish-over',
  ].each do | name |
    it { is_expected.to contain_jenkins__plugin(name).with_version(/\d.*/) }
  end

  it do
    is_expected.to contain_jenkins_plugin__plugins__install_groovy('publish-over-ssh')
  end
end
