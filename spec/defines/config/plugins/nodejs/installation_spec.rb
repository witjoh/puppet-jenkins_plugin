require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_jenkins::config::plugins::nodejs::installation' do

  let(:title) { 'myname' }

  context 'defaults' do
    let(:params) do
      {
        nodejshome: '/my/nodejs/home',
      }
    end

    it do
      is_expected.to contain_jenkins__cli__exec('set_nodejs_installation-myname').with(
        command: 'set_nodejs_installation name:\'myname\' home:/my/nodejs/home',
        unless: "[[ $($HELPER_CMD insync_nodejs_installation \"name:'myname' home:/my/nodejs/home\") == true ]]",
      )
    end
  end

  context 'custom parameters' do
    let(:params) do
      {
        nodejshome: '/another/nodejs/home',
        nodejsname: "nodejs name",
      }
    end

    it do
      is_expected.to contain_jenkins__cli__exec('set_nodejs_installation-myname').with(
        command: 'set_nodejs_installation name:\'nodejs name\' home:/another/nodejs/home',
        unless: "[[ $($HELPER_CMD insync_nodejs_installation \"name:'nodejs name' home:/another/nodejs/home\") == true ]]",
      )
    end
  end

  context 'abenst' do
    let(:params) do
      {
        nodejshome: '/another/nodejs/home',
        ensure: "absent",
        nodejsname: "nodejs name",
      }
    end
    it do
      is_expected.to contain_jenkins__cli__exec('del_nodejs_installation-myname').with(
        command: 'del_nodejs_installation name:\'nodejs name\' home:/another/nodejs/home',
        unless: "[[ -z $($HELPER_CMD get_nodejs_installation nodejs name) ]]",
      )
    end
  end
end
