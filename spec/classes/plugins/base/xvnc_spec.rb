require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::xvnc' do
  it do
    is_expected.to contain_jenkins__plugin('xvnc').with_version(/\d.*/)
  end
end
