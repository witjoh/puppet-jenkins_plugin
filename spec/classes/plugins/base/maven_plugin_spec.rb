require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::maven_plugin' do
  it do
    is_expected.to contain_jenkins__plugin('maven-plugin').with_version(/\d.*/)
  end
end
