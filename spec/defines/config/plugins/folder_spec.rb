require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::config::plugins::folder' do
  let(:title) { 'myfolder' }

  context 'title only' do
    it do
      is_expected.to contain_jenkins__cli__exec('setFolder-myfolder').with(
        command: 'setFolder myfolder',
        unless: '$HELPER_CMD getFolder myfolder | /bin/grep myfolder',
        plugin: 'cloudbees-folder',
      )
    end
  end

  context 'folder => otherfolder' do
    let(:params) do
      {
        folder: 'otherfolder',
      }
    end

    it do
      is_expected.to contain_jenkins__cli__exec('setFolder-myfolder').with(
        command: 'setFolder otherfolder',
        unless: '$HELPER_CMD getFolder otherfolder | /bin/grep otherfolder',
        plugin: 'cloudbees-folder',
      )
    end
  end

  context 'ensure => absent' do
    let(:params) do
      {
        ensure: 'absent',
      }
    end

    it do
      is_expected.to contain_jenkins__cli__exec('removeFolder-myfolder').with(
        command: 'removeFolder myfolder false',
        unless: '[[ -z $($HELPER_CMD getFolder myfolder | /bin/grep myfolder) ]]',
        plugin: 'cloudbees-folder',
      )
    end
  end

  context 'ensure => absent : force_remove => true' do
    let(:params) do
      {
        ensure: 'absent',
        force_remove: true,
      }
    end

    it do
      is_expected.to contain_jenkins__cli__exec('removeFolder-myfolder').with(
        command: 'removeFolder myfolder true',
        unless: '[[ -z $($HELPER_CMD getFolder myfolder | /bin/grep myfolder) ]]',
        plugin: 'cloudbees-folder',
      )
    end
  end

  context 'ensure => absent : folder => otherfolder' do
    let(:params) do
      {
        ensure: 'absent',
        folder: 'otherfolder',
      }
    end

    it do
      is_expected.to contain_jenkins__cli__exec('removeFolder-myfolder').with(
        command: 'removeFolder otherfolder false',
        unless: '[[ -z $($HELPER_CMD getFolder otherfolder | /bin/grep otherfolder) ]]',
        plugin: 'cloudbees-folder',
      )
    end
  end
end
