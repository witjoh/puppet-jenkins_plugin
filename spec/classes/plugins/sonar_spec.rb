require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::sonar' do
  [
    'sonar',
    'credentials',
    'plain-credentials',
  ].each do | name |
    it do
      is_expected.to contain_jenkins__plugin(name).with_version(/\d.*/)
    end
  end

  it do
    is_expected.to contain_jenkins_plugin__plugins__install_groovy('sonar')
  end
end
