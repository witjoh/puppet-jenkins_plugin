require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::config::master::global' do
  context 'default params' do
    let(:facts) do
      {
        'fqdn' => 'jenkins.example.com',
      }
    end

    it do
      is_expected.to contain_class('jenkins_plugin::config::master::groovy')
    end

    it do
      is_expected.to contain_jenkins__cli__exec('set_master_labels undef').with(
        unless: '[ "$($HELPER_CMD get_master_labels)" = "null" ]',
        plugin: 'global',
      )
    end

    it do
      is_expected.to contain_jenkins__cli__exec('set_system_message \'undef\'').with(
        unless: '[ "$($HELPER_CMD get_system_message)" = "null" ]',
        plugin: 'global',
      )
    end

    it do
      is_expected.to contain_jenkins__cli__exec('set_master_usage NORMAL').with(
        unless: '[ $($HELPER_CMD get_master_usage) = NORMAL ]',
        plugin: 'global',
      )
    end

    it do
      is_expected.to contain_jenkins__cli__exec('set_jenkins_url http://jenkins.example.com:8080').with(
        unless: '[ $($HELPER_CMD get_jenkins_url) = http://jenkins.example.com:8080/ ]',
        plugin: 'global',
      )
    end

    it do
      is_expected.to contain_jenkins__cli__exec('set_admin_email \'undef\'').with(
        unless: '[ "$($HELPER_CMD get_admin_email)" = "null" ]',
        plugin: 'global',
      )
    end
  end

  context 'custom params' do
    let(:params) do
      {
        labels: 'testlabel',
        message: 'testmessage',
        restrict_usage: true,
        root_url: 'https://testserver:8080/',
        admin_mail: 'testmail@example.com',
      }
    end

    # add these two lines in a single test block to enable puppet and hiera debug mode
    # Puppet::Util::Log.level = :debug
    # Puppet::Util::Log.newdestination(:console)

    it do
      is_expected.to contain_class('jenkins_plugin::config::master::groovy')
    end

    it do
      is_expected.to contain_jenkins__cli__exec('set_master_labels testlabel').with(
        unless: '[ "$($HELPER_CMD get_master_labels)" = "testlabel" ]',
        plugin: 'global',
      )
    end

    it do
      is_expected.to contain_jenkins__cli__exec('set_system_message \'testmessage\'').with(
        unless: '[ "$($HELPER_CMD get_system_message)" = "testmessage" ]',
        plugin: 'global',
      )
    end

    it do
      is_expected.to contain_jenkins__cli__exec('set_master_usage EXCLUSIVE').with(
        unless: '[ $($HELPER_CMD get_master_usage) = EXCLUSIVE ]',
        plugin: 'global',
      )
    end

    it do
      is_expected.to contain_jenkins__cli__exec('set_jenkins_url https://testserver:8080/').with(
        unless: '[ $($HELPER_CMD get_jenkins_url) = https://testserver:8080/ ]',
        plugin: 'global',
      )
    end

    it do
      is_expected.to contain_jenkins__cli__exec('set_admin_email \'testmail@example.com\'').with(
        unless: '[ "$($HELPER_CMD get_admin_email)" = "testmail@example.com" ]',
        plugin: 'global',
      )
    end
  end
end
