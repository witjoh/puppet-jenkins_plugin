require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::config::master::bootstrap_sshd' do
  let(:pre_condition) { 'include jenkins' }
  it do
    is_expected.to contain_file('/var/lib/jenkins/org.jenkinsci.main.modules.sshd.SSHD.xml').with(
      ensure: 'file',
      replace: 'false',
      content: /<port>35836<\/port>/,
      owner: 'jenkins',
      group: 'jenkins',
    ).that_requires('Class[jenkins::package]')
     .that_comes_before('Class[jenkins::service]')
  end
end
