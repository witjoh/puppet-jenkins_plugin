require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::config::plugins::ssh_site' do
  let(:title) { 'some.ssh.host' }

  context 'with defaults' do
    let(:params) do
      {
        credentialid: 'mycreds',
      }
    end

    it do
      is_expected.to contain_jenkins__cli__exec('set_ssh_remote_host-some.ssh.host').with(
        command: "set_ssh_remote_host hostname:some.ssh.host port:22 credentialid:'mycreds' pty:false serveraliveinterval:0 timeout:0",
        unless: "$HELPER_CMD insync_ssh_remote_host \"hostname:some.ssh.host port:22 credentialid:'mycreds' pty:false serveraliveinterval:0 timeout:0\" | /bin/grep '^true$'",
      )
    end
  end

  context 'with custom settings' do
    let(:params) do
      {
        credentialid: 'othercreds',
        hostname: 'other.ssh.host',
        ensure: 'present',
        port: 2222,
        pty: true,
        serveraliveinterval: 10_000,
        timeout: 100,

      }
    end

    it do
      is_expected.to contain_jenkins__cli__exec('set_ssh_remote_host-some.ssh.host').with(
        command: "set_ssh_remote_host hostname:other.ssh.host port:2222 credentialid:'othercreds' pty:true serveraliveinterval:10000 timeout:100",
        unless: "$HELPER_CMD insync_ssh_remote_host \"hostname:other.ssh.host port:2222 credentialid:'othercreds' pty:true serveraliveinterval:10000 timeout:100\" | /bin/grep '^true$'",
      )
    end
  end

  context 'ensure absent' do
    let(:params) do
      {
        credentialid: 'mycreds',
        ensure: 'absent',
      }
    end

    it do
      is_expected.to contain_jenkins__cli__exec('del_ssh_remote_host-some.ssh.host').with(
        command: "del_ssh_remote_host 'some.ssh.host'",
        unless: "[[ -z $($HELPER_CMD get_ssh_remote_host 'some.ssh.host' | /bin/grep 'some.ssh.host') ]]",
      )
    end
  end
end
