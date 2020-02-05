require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::config::plugins::system::xvnc' do
  context 'false' do
    it do
      is_expected.to contain_jenkins__cli__exec('set_xvnc_global_properties').with(
        command: 'set_xvnc_global_properties false',
        unless: '$HELPER_CMD get_xvnc_global_properties | /bin/grep false',
      )
    end
  end

  context 'true' do
    let(:params) do
      {
        disable: true,
      }
    end

    it do
      is_expected.to contain_jenkins__cli__exec('set_xvnc_global_properties').with(
        command: 'set_xvnc_global_properties true',
        unless: '$HELPER_CMD get_xvnc_global_properties | /bin/grep true',
      )
    end
  end
end
