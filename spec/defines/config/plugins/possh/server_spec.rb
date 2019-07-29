require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::config::plugins::possh::server' do

  let(:title) { 'some ssh server' }

  context 'defaults' do
    let(:params) do
      {
        hostname: 'some.ssh.server',
        username: 'some_ssh_user',
      }
    end

    it do
      is_expected.to contain_jenkins__cli__exec('possh_set_ssh_server-some ssh server').with(
        command: "possh_set_ssh_server name:'some ssh server' hostname:some.ssh.server username:some_ssh_user port:22 timout:300000 disableexec:false",
        unless: "$HELPER_CMD possh_insync_ssh_server \"name:'some ssh server' hostname:some.ssh.server username:some_ssh_user port:22 timout:300000 disableexec:false\" | /bin/grep '^true$'",
      )
    end
  end

  context 'host configuration settings' do
    context 'configname and remoteroordir' do  
      let(:params) do
        {
          hostname: 'some.ssh.server',
          username: 'some_ssh_user',
          configname: 'override config',
          remoterootdir: '/some/remote/root/dir',
        }
      end
      it do
        is_expected.to contain_jenkins__cli__exec('possh_set_ssh_server-some ssh server').with(
          command: "possh_set_ssh_server name:'override config' hostname:some.ssh.server username:some_ssh_user port:22 timout:300000 disableexec:false remoterootdir:/some/remote/root/dir",
          unless: "$HELPER_CMD possh_insync_ssh_server \"name:'override config' hostname:some.ssh.server username:some_ssh_user port:22 timout:300000 disableexec:false remoterootdir:/some/remote/root/dir\" | /bin/grep '^true$'",
        )
      end
    end

    context 'host credentials settings' do
      context 'credentials set, overridekey false' do
        let(:params) do
          {
            hostname: 'some.ssh.server',
            username: 'some_ssh_user',
            overridekey: false,
            encryptedpassword: 'somevalue',
            password: 'plain text',
            keypath: 'somevalue',
            key: 'somevalue',
          }
        end
        it do
          is_expected.to contain_jenkins__cli__exec('possh_set_ssh_server-some ssh server').with(
            command: "possh_set_ssh_server name:'some ssh server' hostname:some.ssh.server username:some_ssh_user port:22 timout:300000 disableexec:false",
            unless: "$HELPER_CMD possh_insync_ssh_server \"name:'some ssh server' hostname:some.ssh.server username:some_ssh_user port:22 timout:300000 disableexec:false\" | /bin/grep '^true$'",
          )
        end
      end
      context 'credentials set, overridekey true' do
        [ :undef, 'somevalue'] .each do | val|
          let(:params) do
            {
              hostname: 'some.ssh.server',
              username: 'some_ssh_user',
              overridekey: true,
              encryptedpassword: 'encrypted',
              password: 'plain text',
              keypath: val,
              key: 'private_key',
            }
          end
          context "ignore password/keypath (#{val}) when encryptedpassword/key set" do
            it do
              is_expected.to contain_jenkins__cli__exec('possh_set_ssh_server-some ssh server').with(
                command: "possh_set_ssh_server name:'some ssh server' hostname:some.ssh.server username:some_ssh_user port:22 timout:300000 disableexec:false overridekey:true encryptedpassword:encrypted password:'plain text' key:'cHJpdmF0ZV9rZXk='",
                unless: "$HELPER_CMD possh_insync_ssh_server \"name:'some ssh server' hostname:some.ssh.server username:some_ssh_user port:22 timout:300000 disableexec:false overridekey:true encryptedpassword:encrypted password:'plain text' key:'cHJpdmF0ZV9rZXk='\" | /bin/grep '^true$'",
              )
            end
          end
        end

        context 'server settings' do
          context 'jumphost set' do
            let(:params) do
              {
                hostname: 'some.ssh.server',
                username: 'some_ssh_user',
                jumphost: 'jump.host.ex',
              }
            end
            it do
              is_expected.to contain_jenkins__cli__exec('possh_set_ssh_server-some ssh server').with(
                command: "possh_set_ssh_server name:'some ssh server' hostname:some.ssh.server username:some_ssh_user port:22 timout:300000 disableexec:false jumphost:jump.host.ex",
                unless: "$HELPER_CMD possh_insync_ssh_server \"name:'some ssh server' hostname:some.ssh.server username:some_ssh_user port:22 timout:300000 disableexec:false jumphost:jump.host.ex\" | /bin/grep '^true$'",
              )
            end

          end
          context 'Server_settings all set except jumphost' do
            let(:params) do
              {
                hostname: 'some.ssh.server',
                username: 'some_ssh_user',
                port: 2222,
                timeout: 666666,
                disableexec: true,
              }
            end
            it do
              is_expected.to contain_jenkins__cli__exec('possh_set_ssh_server-some ssh server').with(
                command: "possh_set_ssh_server name:'some ssh server' hostname:some.ssh.server username:some_ssh_user port:2222 timout:666666 disableexec:true",
                unless: "$HELPER_CMD possh_insync_ssh_server \"name:'some ssh server' hostname:some.ssh.server username:some_ssh_user port:2222 timout:666666 disableexec:true\" | /bin/grep '^true$'",
              )
            end

          end
        end

        context 'proxy settings' do
          context 'no proxytype set' do
            let(:params) do
              {
                hostname: 'some.ssh.server',
                username: 'some_ssh_user',
                proxyhost: 'proxy.host.tst',
                proxyport: 8080,
                proxyuser: 'proxy_user',
                proxypassword: 'proxy_pass',
              }
            end
            it do
              is_expected.to contain_jenkins__cli__exec('possh_set_ssh_server-some ssh server').with(
                command: "possh_set_ssh_server name:'some ssh server' hostname:some.ssh.server username:some_ssh_user port:22 timout:300000 disableexec:false",
                unless: "$HELPER_CMD possh_insync_ssh_server \"name:'some ssh server' hostname:some.ssh.server username:some_ssh_user port:22 timout:300000 disableexec:false\" | /bin/grep '^true$'",
              )
            end
          end
          context 'proxytype set' do
            let(:params) do
              {
                hostname: 'some.ssh.server',
                username: 'some_ssh_user',
                proxytype: 'http',
                proxyhost: 'proxy.host.tst',
                proxyport: 8080,
                proxyuser: 'proxy_user',
                proxypassword: 'proxy_pass',
              }
            end

            it do
              is_expected.to contain_jenkins__cli__exec('possh_set_ssh_server-some ssh server').with(
                command: "possh_set_ssh_server name:'some ssh server' hostname:some.ssh.server username:some_ssh_user port:22 timout:300000 disableexec:false  proxytype:http proxyport:8080proxyhost:proxy.host.tst proxyuser:'proxy_user' proxypassword:'proxy_pass'",
               unless: "$HELPER_CMD possh_insync_ssh_server \"name:'some ssh server' hostname:some.ssh.server username:some_ssh_user port:22 timout:300000 disableexec:false  proxytype:http proxyport:8080proxyhost:proxy.host.tst proxyuser:'proxy_user' proxypassword:'proxy_pass'\" | /bin/grep '^true$'",
              )
            end
          end

          context 'ensure = absent configname set' do
            let(:params) do
              {
                hostname: 'some.ssh.server',
                username: 'some_ssh_user',
                ensure: "absent",
                configname: 'overrided',
              }
            end
            it do
              is_expected.to contain_jenkins__cli__exec('poshh_del_ssh_server-some ssh server').with(
                command: "possh_del_ssh_server 'overrided'",
                unless: "[[ -z $($HELPER_CMD poshh_get_ssh_server 'overrided' | /bin/grep 'overrided') ]]",
              )
            end
          end

          context 'ensure = absent and ' do
            let(:params) do
              {
                hostname: 'some.ssh.server',
                username: 'some_ssh_user',
                ensure: "absent",
              }
            end
            it do
              is_expected.to contain_jenkins__cli__exec('poshh_del_ssh_server-some ssh server').with(
                command: "possh_del_ssh_server 'some ssh server'",
                unless: "[[ -z $($HELPER_CMD poshh_get_ssh_server 'some ssh server' | /bin/grep 'some ssh server') ]]",
              )
            end
          end
        end
      end
    end
  end
end
