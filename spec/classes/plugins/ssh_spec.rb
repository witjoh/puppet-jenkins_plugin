require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::ssh' do
  it do
    is_expected.to contain_Jenkins_plugin__Plugins__Install_groovy('ssh')
  end

  ['ssh',
   'jsch',
   'ssh-credentials'].each do |name|
    it do
      is_expected.to contain_jenkins__plugin(name).with_version(%r{\d.*})
    end
  end
end
