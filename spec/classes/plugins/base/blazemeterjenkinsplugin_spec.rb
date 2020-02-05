require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::blazemeterjenkinsplugin' do
  it do
    is_expected.to contain_jenkins__plugin('BlazeMeterJenkinsPlugin').with_version(%r{\d.*})
  end
end
