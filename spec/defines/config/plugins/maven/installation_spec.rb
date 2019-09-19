require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::config::plugins::maven::installation' do

  let(:title) { 'my_maven' }

  context 'default parameters' do
    let(:params) do
      {
        mavenhome: '/my/maven/home',
      }
    end

    it do
      is_expected.to contain_jenkins_plugin__plugins__install_groovy('maven-plugin')
    end

    it do
      is_expected.to contain_jenkins__cli__exec('maven_set_installation-my_maven').with(
        command: "maven_set_installation name:'my_maven' mavenhome:/my/maven/home",
        unless: '[[ $($HELPER_CMD maven_insync_installation "name:\'my_maven\' mavenhome:/my/maven/home") == true ]]',
      )
    end
  end

  context 'custom parameters' do
    let(:params) do
      {
        mavenhome: '/other/maven/home',
        mavenname: 'other_maven',
      }
    end

    it do
      is_expected.to contain_jenkins__cli__exec('maven_set_installation-my_maven').with(
        command: "maven_set_installation name:'other_maven' mavenhome:/other/maven/home",
        unless: '[[ $($HELPER_CMD maven_insync_installation "name:\'other_maven\' mavenhome:/other/maven/home") == true ]]',
      )
    end
  end

  context 'with ensure is absent' do
    let(:params) do
      {
        ensure: 'absent',
        mavenhome: '/other/maven/home',
        mavenname: 'other_maven',
      }
    end

    it do
      is_expected.to contain_jenkins__cli__exec('maven_del_installation-my_maven').with(
        command: 'maven_del_installation other_maven',
        unless: '[[ -z $($HELPER_CMD maven_get_installation other_maven) ]]',
      )
    end
  end
end
