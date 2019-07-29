require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::prescmbuildstep' do
  it do
    is_expected.to contain_jenkins__plugin('preSCMbuildstep').with_version(/\d.*/)
  end
end
