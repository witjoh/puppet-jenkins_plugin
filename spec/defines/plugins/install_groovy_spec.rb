require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::install_groovy' do
  let(:title) { 'myplugin' }

  context 'default params' do
    it do
      is_expected.to contain_file('/usr/lib/jenkins/groovy/plugins/myplugin/puppet_helper_myplugin.groovy').with(
        ensure: 'file',
        source: 'puppet:///modules/jenkins_plugin/groovy/plugins/myplugin/puppet_helper_myplugin.groovy',
      )
    end

    [
      'groovy',
      'groovy/plugins',
      'groovy/plugins/myplugin',
    ].each do |item|
      it do
        is_expected.to contain_file("/usr/lib/jenkins/#{item}").with(
          owner: 'jenkins',
          group: 'jenkins',
          mode: '0640',
        )
      end
    end

    it do
      is_expected.to contain_class('jenkins_plugin::config::plugins::lib')
    end
  end

  context 'ensure => absent' do
    let(:params) do
      {
        ensure: 'absent',
      }
    end

    it do
      is_expected.to contain_file('/usr/lib/jenkins/groovy/plugins/myplugin/puppet_helper_myplugin.groovy').with(
        ensure: 'absent',
        source: 'puppet:///modules/jenkins_plugin/groovy/plugins/myplugin/puppet_helper_myplugin.groovy',
      )
    end
  end

  context 'source => custom' do
    let(:params) do
      {
        ensure: 'present',
        source: 'foo',
      }
    end

    it do
      is_expected.to contain_file('/usr/lib/jenkins/groovy/plugins/myplugin/puppet_helper_myplugin.groovy').with(
        ensure: 'file',
        source: 'foo',
      )
    end
  end
end
