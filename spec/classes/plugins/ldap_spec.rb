require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::ldap' do
  it do
    is_expected.to contain_jenkins_plugin__plugins__install_groovy('ldap')
  end

  ['ldap'].each do |name|
    it do
      is_expected.to contain_jenkins__plugin(name).with_version(%r{\d.*})
    end
  end
end
