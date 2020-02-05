require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::config::master::env' do
  let(:title) { 'MyKey' }

  context 'env_value only set' do
    let(:params) do
      {
        env_value: 'foo',
        # env_key: "$title",
        # ensure: "present",
      }
    end

    it do
      is_expected.to contain_jenkins__cli__exec('set_global_env-MyKey').with(
        command: 'set_global_env MYKEY foo',
        unless: '[[ $($HELPER_CMD get_global_env MYKEY) == foo ]]',
        plugin: 'global',
      )
    end
  end

  context 'env_key set' do
    let(:params) do
      {
        env_value: 'foo',
        env_key: 'bar',
        # ensure: "present",
      }
    end

    it do
      is_expected.to contain_jenkins__cli__exec('set_global_env-MyKey').with(
        command: 'set_global_env BAR foo',
        unless: '[[ $($HELPER_CMD get_global_env BAR) == foo ]]',
        plugin: 'global',
      )
    end
  end

  context 'force_upcase is false' do
    let(:params) do
      {
        env_value: 'foo',
        env_key: 'bar',
        force_upcase: false,
      }
    end

    it do
      is_expected.to contain_jenkins__cli__exec('set_global_env-MyKey').with(
        command: 'set_global_env bar foo',
        unless: '[[ $($HELPER_CMD get_global_env bar) == foo ]]',
        plugin: 'global',
      )
    end
  end

  context 'absent' do
    let(:params) do
      {
        ensure: 'absent',
      }
    end

    it do
      is_expected.to contain_jenkins__cli__exec('del_global_env-MyKey').with(
        command: 'del_global_env MYKEY',
        unless: '[[ -z $($HELPER_CMD get_global_env MYKEY) ]]',
        plugin: 'global',
      )
    end
  end

  context 'fail if env_var unset' do
    let(:params) do
      {
        ensure: 'present',
      }
    end

    it { is_expected.to compile.and_raise_error(%r{The attribute \$env_value must be set when \$ensure => present !}) }
  end
end
