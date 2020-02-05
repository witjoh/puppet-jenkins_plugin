require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::conditional_buildstep' do
  it do
    is_expected.to contain_jenkins__plugin('conditional-buildstep').with_version(%r{\d.*})
  end
end
