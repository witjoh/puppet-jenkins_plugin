require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::config::plugins::possh::common' do
  context 'with defaults' do
    it do
      is_expected.to contain_jenkins__cli__exec('possh_set_common_config').with(
        command: "possh_set_common_config disableallexec:false",
        unless: "[[ $($HELPER_CMD possh_insync_common_config disableallexec:false) == true ]]"
      )
    end
  end

  context 'with encrypted passphrase' do
    let(:params) do
      {
        encryptedpassphrase: 'encrypted',
      }
    end
    it do
      is_expected.to contain_jenkins__cli__exec('possh_set_common_config').with(
        command: "possh_set_common_config encryptedpassphrase:encrypted disableallexec:false",
        unless: "[[ $($HELPER_CMD possh_insync_common_config encryptedpassphrase:encrypted disableallexec:false) == true ]]"
      )
    end
  end

  context 'keypath/key' do
    context 'keypath only' do
      let(:params) do
        {
          keypath: 'my/key/path',
        }
      end
      it do
        is_expected.to contain_jenkins__cli__exec('possh_set_common_config').with(
          command: "possh_set_common_config keypath:my/key/path disableallexec:false",
          unless: "[[ $($HELPER_CMD possh_insync_common_config keypath:my/key/path disableallexec:false) == true ]]"
        )
      end
    end
    context 'key and/or keyspath set' do
      [ :undef, 'my/key/path' ].each do | p |
        let(:params) do
          {
            keypath: p,
            key: 'encrypted',
          }
        end
        it do
          is_expected.to contain_jenkins__cli__exec('possh_set_common_config').with(
            command: "possh_set_common_config key:'ZW5jcnlwdGVk' disableallexec:false",
            unless: "[[ $($HELPER_CMD possh_insync_common_config key:'ZW5jcnlwdGVk' disableallexec:false) == true ]]"
          )
        end
      end
    end
  end

  context 'with disableexec true' do
    let(:params) do
      {
        disableallexec: true,
      }
    end
    it do
      is_expected.to contain_jenkins__cli__exec('possh_set_common_config').with(
        command: "possh_set_common_config disableallexec:true",
        unless: "[[ $($HELPER_CMD possh_insync_common_config disableallexec:true) == true ]]"
      )
    end
  end
end
