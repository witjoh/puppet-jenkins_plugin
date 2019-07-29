require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::config::plugins::sonar::config' do

  let(:title) { 'my_sonar' }

  context 'default parameters' do
    let(:params) do
      {
        serverurl: 'http://sonarlts.somewhere.world:9000',
        credentialsid: 'tokenid',
      }
    end

    it do
      is_expected.to contain_jenkins__cli__exec('sonar_set_globalconfig-my_sonar').with(
        command: 'sonar_set_globalconfig name:\'my_sonar\' credentialsid:\'tokenid\' serverurl:http://sonarlts.somewhere.world:9000',
        unless: '[[ $($HELPER_CMD sonar_insync_globalconfig "name:\'my_sonar\' credentialsid:\'tokenid\' serverurl:http://sonarlts.somewhere.world:9000") == true ]]',
      )
    end
  end

  context 'custom parameters' do
    let(:params) do
      {
        credentialsid: 'othertoken',
        serverurl: 'http://new.sonar.ex:9999',
        sonarname: 'other_sonar',
        mojoversion: '666',
        additionalanalysisproperties: 'analysis',
        additionalproperties: 'properties',
      }
    end

    it do
      is_expected.to contain_jenkins__cli__exec('sonar_set_globalconfig-my_sonar').with(
        command: "sonar_set_globalconfig name:'other_sonar' credentialsid:'othertoken' serverurl:http://new.sonar.ex:9999 mojoversion:666 additionalanalysisproperties:'analysis' additionalproperties:'properties'",
        unless: "[[ $($HELPER_CMD sonar_insync_globalconfig \"name:'other_sonar' credentialsid:'othertoken' serverurl:http://new.sonar.ex:9999 mojoversion:666 additionalanalysisproperties:'analysis' additionalproperties:'properties'\") == true ]]",
      )
    end
  end

  context 'with ensure is absent' do
    let(:params) do
      {
        ensure: 'absent',
        serverurl: 'http://new.sonar.ex:9999',
        credentialsid: 'dummy',
        sonarname: 'other_sonar',
      }
    end

    it do
      is_expected.to contain_jenkins__cli__exec('sonar_del_globalconfig-my_sonar').with(
        command: 'sonar_del_globalconfig other_sonar',
        unless: '[[ -z $($HELPER_CMD sonar_get_globalconfig other_sonar) ]]',
      )
    end
  end
end
