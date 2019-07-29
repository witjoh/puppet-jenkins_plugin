require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::folders' do
  it do
    is_expected.to contain_jenkins_plugin__plugins__install_groovy('cloudbees-folder')
  end

  ['cloudbees-folder',
  ].each do | name |
    it do
      is_expected.to contain_jenkins__plugin(name).with_version(/\d.*/)
    end
  end
end
