require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::build_name_setter' do
  it do
    is_expected.to contain_jenkins__plugin('build-name-setter').with_version(%r{\d.*})
  end
end
