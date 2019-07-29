require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::sonar' do
  it do
    is_expected.to contain_jenkins__plugin('sonar').with_version(/\d.*/)
  end
end
