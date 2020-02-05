require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::javadoc' do
  it do
    is_expected.to contain_jenkins__plugin('javadoc').with_version(%r{\d.*})
  end
end
