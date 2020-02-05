require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::ldap' do
  it do
    is_expected.to contain_jenkins__plugin('ldap').with_version(%r{\d.*})
  end
end
