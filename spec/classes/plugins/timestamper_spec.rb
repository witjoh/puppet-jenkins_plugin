require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::timestamper' do
  [ 'timestamper',
    'workflow-api',
    'workflow-step-api',
    'scm-api',
    'structs',
  ].each do | name |
    it do
      is_expected.to contain_jenkins__plugin(name).with_version(/\d.*/)
    end
  end
end

