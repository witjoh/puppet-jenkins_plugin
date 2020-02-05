require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::config_file_provider' do
  it do
    is_expected.to contain_jenkins_plugin__plugins__install_groovy('config-file-provider')
  end

  ['config-file-provider',
   'credentials',
   'ssh-credentials',
   'structs',
   'token-macro'].each do |name|
    it do
      is_expected.to contain_jenkins__plugin(name).with_version(%r{\d.*})
    end
  end
end
