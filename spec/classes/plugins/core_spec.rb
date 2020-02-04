require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::core' do

  [ 'bouncycastle-api',
    'windows-slaves',
  ].each do | name |
    context 'pre 2.190 version' do
      let(:facts) do
        {
          'jenkins_version' => '2.172.2',
        }
      end

      it do
        is_expected.not_to contain_jenkins__plugin(name).with_version(/\d.*/)
      end
    end

    context 'starting from 2.190 version' do
      let(:facts) do
        {
          'jenkins_version' => '2.190.1',
        }
      end

      it do
        is_expected.to contain_jenkins__plugin(name).with_version(/\d.*/)
      end
    end
  end
end
