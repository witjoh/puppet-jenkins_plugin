require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::blazemeterjenkinsplugin' do
  ['BlazeMeterJenkinsPlugin',
   'workflow-step-api',
   'credentials',
   'structs'].each do |name|
    it do
      is_expected.to contain_jenkins__plugin(name).with_version(%r{\d.*})
    end
  end
end
