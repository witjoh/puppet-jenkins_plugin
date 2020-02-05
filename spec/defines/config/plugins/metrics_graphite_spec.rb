require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::config::plugins::metrics_graphite' do
  let(:title) { 'graphite.server.ex' }

  context 'present' do
    context 'defaults' do
      it do
        is_expected.to contain_jenkins__cli__exec('graphite_set_server-graphite.server.ex').with(
          command: 'graphite_set_server hostname:graphite.server.ex port:2003',
          unless: '[[ $($HELPER_CMD graphite_insync_server hostname:graphite.server.ex port:2003) == true ]]',
          plugin: 'metrics-graphite',
        )
      end
    end

    context 'specific' do
      let(:params) do
        {
          ensure: 'present',
          hostname: 'other.server.spec',
          port: 666,
          prefix: 'foo text',
        }
      end

      it do
        is_expected.to contain_jenkins__cli__exec('graphite_set_server-graphite.server.ex').with(
          command: 'graphite_set_server hostname:other.server.spec port:666 prefix:\'foo text\'',
          unless: '[[ $($HELPER_CMD graphite_insync_server hostname:other.server.spec port:666 prefix:\'foo text\') == true ]]',
          plugin: 'metrics-graphite',
        )
      end
    end
  end

  context 'absent' do
    context 'default' do
      let(:params) do
        {
          ensure: 'absent',
        }
      end

      it do
        is_expected.to contain_jenkins__cli__exec('graphite_del_server-graphite.server.ex').with(
          command: 'graphite_del_server graphite.server.ex',
          unless: '[[ -z $($HELPER_CMD graphite_insync_server graphite.server.ex) ]]',
          plugin: 'metrics-graphite',
        )
      end
    end
    context 'specific' do
      let(:params) do
        {
          ensure: 'absent',
          hostname: 'other.server.spec',
          port: 666,
          prefix: 'foo text',
        }
      end

      it do
        is_expected.to contain_jenkins__cli__exec('graphite_del_server-graphite.server.ex').with(
          command: 'graphite_del_server other.server.spec',
          unless: '[[ -z $($HELPER_CMD graphite_insync_server other.server.spec) ]]',
          plugin: 'metrics-graphite',
        )
      end
    end
  end
end
