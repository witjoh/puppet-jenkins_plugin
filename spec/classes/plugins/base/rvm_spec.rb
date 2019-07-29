require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::rvm' do
  it do
    is_expected.to contain_jenkins__plugin('rvm').with_version(/\d.*/)
  end
end
