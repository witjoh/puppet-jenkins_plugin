require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::config::plugins::sonar::runner' do

  let(:title) { 'my_runner' }

  context 'default parameters' do
    let(:params) do
      {
        home: '/my/runner/home',
      } 
    end

    it do
      is_expected.to contain_jenkins__cli__exec('sonar_set_runner-my_runner').with(
        command: 'sonar_set_runner name:my_runner home:/my/runner/home',
        unless: '[[ $($HELPER_CMD sonar_insync_runner "name:my_runner home:/my/runner/home") == true ]]',
      )
    end
  end

  context 'custom parameters' do
    let(:params) do
      {
        home: '/other/runner/home',
        runnername: 'other_runner',
      }
    end

    it do
      is_expected.to contain_jenkins__cli__exec('sonar_set_runner-my_runner').with(
        command: 'sonar_set_runner name:other_runner home:/other/runner/home',
        unless: '[[ $($HELPER_CMD sonar_insync_runner "name:other_runner home:/other/runner/home") == true ]]',
      )
    end
  end

  context 'with ensure is absent' do
    let(:params) do
      {
        ensure: 'absent',
        home: '/other/runner/home',
        runnername: 'other_runner',
      }
    end

    it do
      is_expected.to contain_jenkins__cli__exec('sonar_del_runner-my_runner').with(
        command: 'sonar_del_runner other_runner',
        unless: '[[ -z $($HELPER_CMD sonar_get_runner other_runner) ]]',
      )
    end
  end
end
