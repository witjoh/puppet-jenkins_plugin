require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::metrics' do
  it do
    is_expected.to contain_jenkins__plugin('metrics').with_version(/\d.*/)
  end
end
