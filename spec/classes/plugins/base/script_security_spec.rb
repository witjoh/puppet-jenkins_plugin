require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::script_security' do
  it do
    is_expected.to contain_jenkins__plugin('script-security').with_version(/\d.*/)
  end
end
