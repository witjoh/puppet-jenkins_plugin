require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::config::plugins::xvnc' do
  context 'default params' do
    let(:params) do
      {
        commandline: 'xvnc_settings',
      }
    end

    it do
      is_expected.to contain_jenkins__cli__exec('set_xvnc').with(
        command: "set_xvnc commandline:'xvnc_settings'",
        unless: "[[ $($HELPER_CMD insync_xvnc \"commandline:'xvnc_settings'\") == true ]]",
        plugin: 'xvnc',
      )
    end
  end

  context 'custom params' do
    let(:params) do
      {
        commandline: 'new_xvnc_settings',
        mindisplaynumber: 100,
        maxdisplaynumber: 199,
        cleanup: true,
      }
    end

    it do
      is_expected.to contain_jenkins__cli__exec('set_xvnc').with(
        command: "set_xvnc commandline:'new_xvnc_settings' mindisplaynumber:100 maxdisplaynumber:199 cleanup:true",
        unless: "[[ $($HELPER_CMD insync_xvnc \"commandline:'new_xvnc_settings' mindisplaynumber:100 maxdisplaynumber:199 cleanup:true\") == true ]]",
        plugin: 'xvnc',
      )
    end
  end
end
