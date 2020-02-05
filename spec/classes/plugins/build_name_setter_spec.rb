require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::build_name_setter' do
  [
    'build-name-setter',
    'matrix-project',
    'token-macro',
  ].each do |name|
    it do
      is_expected.to contain_jenkins__plugin(name).with_version(%r{\d.*})
    end
  end
end
