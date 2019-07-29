require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::copyartifact' do
  [
    'copyartifact',
    'apache-httpcomponents-client-4-api',
    'matrix-project',
    'scm-api',
  ].each do | name |
    it do
      is_expected.to contain_jenkins__plugin(name).with_version(/\d.*/)
    end
  end
  
end
