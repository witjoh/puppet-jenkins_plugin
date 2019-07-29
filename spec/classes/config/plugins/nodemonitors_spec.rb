require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::config::plugins::nodemonitors' do

  let(:params) do
    {
      # architecture: true,
      # clock: true,
      # diskspace: true,
      # diskspacethreshold: "1GB",
      # swapspace: true,
      # tempspace: true,
      # tempspacethreshold: "1GB",
      # responsetime: true,
    }
  end

  context 'defaults' do

    it do
      is_expected.to contain_jenkins_plugin__plugins__install_groovy('nodemonitors')
    end

    it do
      is_expected.to contain_jenkins__cli__exec('set_monitors').with(
        command: 'set_monitors architecture:true clock:true diskspace:true diskspacethreshold:1GB swapspace:true tempspace:true tempspacethreshold:1GB responsetime:true',
        unless: "[[ $($HELPER_CMD insync_monitors \"architecture:true clock:true diskspace:true diskspacethreshold:1GB swapspace:true tempspace:true tempspacethreshold:1GB responsetime:true\") == true ]]",
      )
    end
  end

  context 'custom parameters' do
    context 'architecture: false' do
      let(:params) do
        {
          architecture: false,
        }
      end
      it do
        is_expected.to contain_jenkins__cli__exec('set_monitors').with(
          command: /architecture:false/,
          unless: /architecture:false/,
        )
      end
    end
  end

  context 'clock: false' do
    let(:params) do
      {
        clock: false,
      }
    end
    it do
      is_expected.to contain_jenkins__cli__exec('set_monitors').with(
        command: /clock:false/,
        unless: /clock:false/,
      )
    end
  end

  context 'diskspace: false' do
    let(:params) do
      {
        diskspace: false,
      }
    end
    it do
      is_expected.to contain_jenkins__cli__exec('set_monitors').with(
        command: /diskspace:false/,
        unless: /diskspace:false/,
      )
    end
  end

  context 'diskspacethreshold: 512MB' do
    let(:params) do
      {
        diskspacethreshold: "512MB",
      }
    end
    it do
      is_expected.to contain_jenkins__cli__exec('set_monitors').with(
        command: /diskspacethreshold:512MB/,
        unless: /diskspacethreshold:512MB/,
      )
    end
  end

  context 'swapspace: false' do
    let(:params) do
      {
        swapspace: false,
      }
    end
    it do
      is_expected.to contain_jenkins__cli__exec('set_monitors').with(
        command: /swapspace:false/,
        unless: /swapspace:false/,
      )
    end
  end

  context 'tempspace: false' do
    let(:params) do
      {
        tempspace: false,
      }
    end
    it do
      is_expected.to contain_jenkins__cli__exec('set_monitors').with(
        command: /tempspace:false/,
        unless: /tempspace:false/,
      )
    end
  end

  context 'tempspacethreshold: 128m' do
    let(:params) do
      {
        tempspacethreshold: "128m",
      }
    end
    it do
      is_expected.to contain_jenkins__cli__exec('set_monitors').with(
        command: /tempspacethreshold:128m/,
        unless: /tempspacethreshold:128m/,
      )
    end
  end

  context 'responsetime: false' do
    let(:params) do
      {
        responsetime: false,
      }
    end
    it do
      is_expected.to contain_jenkins__cli__exec('set_monitors').with(
        command: /responsetime:false/,
        unless: /responsetime:false/,
      )
    end
  end
end
