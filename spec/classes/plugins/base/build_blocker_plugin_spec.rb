require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::build_blocker_plugin' do
  it do
    is_expected.to contain_jenkins__plugin('build-blocker-plugin').with_version(/\d.*/)
  end
end
