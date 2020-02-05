require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::nodejs' do
  it do
    is_expected.to contain_jenkins_plugin__plugins__install_groovy('nodejs')
  end

  ['nodejs',
   'config-file-provider',
   'structs'].each do |name|
    it do
      is_expected.to contain_jenkins__plugin(name).with_version(%r{\d.*})
    end
  end
end
