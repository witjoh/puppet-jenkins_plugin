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

    # rubocop:disable LineLength
    it do
      is_expected.to contain_jenkins__cli__exec('set_monitors').with(
        command: 'set_monitors architecture:true clock:true diskspace:true diskspacethreshold:1GB swapspace:true tempspace:true tempspacethreshold:1GB responsetime:true',
        unless: '[[ $($HELPER_CMD insync_monitors "architecture:true clock:true diskspace:true diskspacethreshold:1GB swapspace:true tempspace:true tempspacethreshold:1GB responsetime:true") == true ]]',
      )
    end
  end
  # rubocop:enable LineLength

  context 'custom parameters' do
    context 'architecture: false' do
      let(:params) do
        {
          architecture: false,
        }
      end

      it do
        is_expected.to contain_jenkins__cli__exec('set_monitors').with(
          command: %r{architecture:false},
          unless: %r{architecture:false},
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
        command: %r{clock:false},
        unless: %r{clock:false},
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
        command: %r{diskspace:false},
        unless: %r{diskspace:false},
      )
    end
  end

  context 'diskspacethreshold: 512MB' do
    let(:params) do
      {
        diskspacethreshold: '512MB',
      }
    end

    it do
      is_expected.to contain_jenkins__cli__exec('set_monitors').with(
        command: %r{diskspacethreshold:512MB},
        unless: %r{diskspacethreshold:512MB},
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
        command: %r{swapspace:false},
        unless: %r{swapspace:false},
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
        command: %r{tempspace:false},
        unless: %r{tempspace:false},
      )
    end
  end

  context 'tempspacethreshold: 128m' do
    let(:params) do
      {
        tempspacethreshold: '128m',
      }
    end

    it do
      is_expected.to contain_jenkins__cli__exec('set_monitors').with(
        command: %r{tempspacethreshold:128m},
        unless: %r{tempspacethreshold:128m},
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
        command: %r{responsetime:false},
        unless: %r{responsetime:false},
      )
    end
  end
end
