require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::variant' do
  it do
    is_expected.to contain_jenkins__plugin('variant').with_version(%r{\d.*})
  end
end
