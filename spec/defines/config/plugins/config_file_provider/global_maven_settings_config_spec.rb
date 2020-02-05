require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::config::plugins::config_file_provider::global_maven_settings_config' do
  let(:title) { 'myconfig' }

  context 'defaults' do
    let(:params) do
      {
        config_name: 'foo name',
        content: 'foo content',
        comment: 'foo_comment',
      }
    end

    it do
      is_expected.to contain_jenkins__cli__exec('set_global_maven_settings_config-myconfig').with(
        command: "set_global_maven_settings_config id:myconfig name:'foo name' content:Zm9vIGNvbnRlbnQ= isencoded:true comment:'foo_comment'",
        unless: "[[ $($HELPER_CMD insync_global_maven_settings_config \"id:myconfig name:'foo name' content:Zm9vIGNvbnRlbnQ= isencoded:true comment:'foo_comment'\") == true ]]",
      )
    end
  end

  context 'override config_id' do
    let(:params) do
      {
        config_id: 'override',
        config_name: 'foo name',
        content: 'foo content',
        comment: 'foo_comment',
        # ensure: "present",
      }
    end

    it do
      is_expected.to contain_jenkins__cli__exec('set_global_maven_settings_config-myconfig').with(
        command: "set_global_maven_settings_config id:override name:'foo name' content:Zm9vIGNvbnRlbnQ= isencoded:true comment:'foo_comment'",
        unless: "[[ $($HELPER_CMD insync_global_maven_settings_config \"id:override name:'foo name' content:Zm9vIGNvbnRlbnQ= isencoded:true comment:'foo_comment'\") == true ]]",
      )
    end
  end

  context 'encode content' do
    let(:params) do
      {
        config_name: 'foo name',
        content: 'foo content',
        comment: 'foo_comment',
        encode_content: false,
      }
    end

    it do
      is_expected.to contain_jenkins__cli__exec('set_global_maven_settings_config-myconfig').with(
        command: "set_global_maven_settings_config id:myconfig name:'foo name' content:'foo content' isencoded:false comment:'foo_comment'",
        unless: "[[ $($HELPER_CMD insync_global_maven_settings_config \"id:myconfig name:'foo name' content:'foo content' isencoded:false comment:'foo_comment'\") == true ]]",
      )
    end
  end

  context 'absent' do
    let(:params) do
      {
        # config_id: nil,
        config_name: 'foo name',
        content: 'foo content',
        comment: 'foo_comment',
        ensure: 'absent',
      }
    end

    it do
      is_expected.to contain_jenkins__cli__exec('del_global_maven_settings_config-myconfig').with(
        command: 'del_global_maven_settings_config id:myconfig',
        unless: '[[ -z $($HELPER_CMD get_global_maven_settings_config myconfig) ]]',
      )
    end
  end
end
