require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::config::plugins::jdk' do
  let(:title) { 'somejdk' }

  context 'defaults' do
    let(:params) do
      {
        javahome: '/some/java/home',
        # ensure: "present",
        # jdkname: "$title",
      }
    end

    it do
      is_expected.to contain_jenkins_plugin__plugins__install_groovy('jdk')
    end

    it do
      is_expected.to contain_jenkins__cli__exec('set_jdk_installation-somejdk').with(
        command: "set_jdk_installation name:'somejdk' javahome:/some/java/home",
        unless: "$HELPER_CMD insync_jdk_installation \"name:'somejdk' javahome:/some/java/home\" | /bin/grep '^true$'",
      )
    end
  end

  context 'overrided' do
    let(:params) do
      {
        javahome: '/some/other/home',
        jdkname: 'overrided name',
      }
    end

    it do
      is_expected.to contain_jenkins__cli__exec('set_jdk_installation-somejdk').with(
        command: "set_jdk_installation name:'overrided name' javahome:/some/other/home",
        unless: "$HELPER_CMD insync_jdk_installation \"name:'overrided name' javahome:/some/other/home\" | /bin/grep '^true$'",
      )
    end
  end

  context 'absent' do
    let(:params) do
      {
        javahome: '/some/other/home',
        ensure: 'absent',
      }
    end

    it do
      is_expected.to contain_jenkins__cli__exec('del_jdk_installation-somejdk').with(
        command: "del_jdk_installation name:'somejdk' javahome:/some/other/home",
        unless: "[[ -z $($HELPER_CMD get_jdk_installation name:'somejdk' javahome:/some/other/home | /bin/grep 'somejdk') ]]",
      )
    end
  end
end
