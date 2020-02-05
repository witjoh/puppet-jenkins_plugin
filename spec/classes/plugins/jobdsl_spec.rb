require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::jobdsl' do
  ['job-dsl'].each do |name|
    it do
      is_expected.to contain_jenkins__plugin(name).with_version(%r{\d.*})
    end
  end
end
