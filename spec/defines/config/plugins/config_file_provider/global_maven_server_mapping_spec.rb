require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::config::plugins::config_file_provider::global_maven_server_mapping' do
  let(:title) { 'foo' }

  context 'present' do
    let(:params) do
      {
        maven_configid: 'mavenid',
        serverid: 'serverid',
        credentialsid: 'credsid',
        # ensure: "present",
      }
    end

    it do
      is_expected.to contain_jenkins__cli__exec('set_global_maven_server_mapping-mavenid-serverid').with(
        command: 'set_global_maven_server_mapping globalmavenconfigid:\'mavenid\' serverid:\'serverid\' credentialsid:\'credsid\'',
        unless: '[[ $($HELPER_CMD insync_global_maven_server_mapping "globalmavenconfigid:\'mavenid\' serverid:\'serverid\' credentialsid:\'credsid\'") == true ]]',
      )
    end
  end

  context 'absent' do
    let(:params) do
      {
        maven_configid: 'mavenid',
        serverid: 'serverid',
        credentialsid: 'credsid',
        ensure: 'absent',
      }
    end

    it do
      is_expected.to contain_jenkins__cli__exec('del_global_maven_server_mapping-mavenid-serverid').with(
        command: 'del_global_maven_server_mapping globalmavenconfigid:\'mavenid\' serverid:\'serverid\' credentialsid:\'credsid\'',
        unless: '[[ -z $($HELPER_CMD get_global_maven_server_mapping globalmavenconfigid:\'mavenid\' serverid:\'serverid\' credentialsid:\'credsid\') ]]',
      )
    end
  end
end
