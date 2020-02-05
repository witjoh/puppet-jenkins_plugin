require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::config::master::security' do
  context 'default params' do
    it do
      is_expected.to contain_class('jenkins_plugin::config::master::groovy')
    end

    it do
      is_expected.to contain_jenkins__cli__exec('set_crumb_issuer false').with(
        unless: '[ $($HELPER_CMD get_crumb_issuer) = off ]',
        plugin: 'global',
      )
    end

    it do
      is_expected.to contain_jenkins__cli__exec('set_cli_remoting false').with(
        unless: "$HELPER_CMD get_cli_remoting |/bin/grep -E 'off|removed'",
        plugin: 'global',
      )
    end

    it do
      is_expected.to contain_jenkins__cli__exec('set_agent_master_kill_switch true').with(
        unless: '[ $($HELPER_CMD get_agent_master_kill_switch) = on ]',
        plugin: 'global',
      )
    end

    it do
      is_expected.to contain_jenkins__cli__exec('set_sshd_port -1').with(
        unless: '[ $($HELPER_CMD get_sshd_port) = -1 ]',
        plugin: 'global',
      )
    end
  end

  context 'custom params' do
    let(:params) do
      {
        csfr_protection: true,
        cli_remoting: true,
        agent_master_kill_switch: false,
        sshd_port: 1234,
      }
    end

    it do
      is_expected.to contain_class('jenkins_plugin::config::master::groovy')
    end

    it do
      is_expected.to contain_jenkins__cli__exec('set_crumb_issuer true').with(
        unless: '[ $($HELPER_CMD get_crumb_issuer) = on ]',
        plugin: 'global',
      )
    end

    it do
      is_expected.to contain_jenkins__cli__exec('set_cli_remoting true').with(
        unless: "$HELPER_CMD get_cli_remoting |/bin/grep -E 'on|removed'",
        plugin: 'global',
      )
    end

    it do
      is_expected.to contain_jenkins__cli__exec('set_agent_master_kill_switch false').with(
        unless: '[ $($HELPER_CMD get_agent_master_kill_switch) = off ]',
        plugin: 'global',
      )
    end

    it do
      is_expected.to contain_jenkins__cli__exec('set_sshd_port 1234').with(
        unless: '[ $($HELPER_CMD get_sshd_port) = 1234 ]',
        plugin: 'global',
      )
    end
  end
end
