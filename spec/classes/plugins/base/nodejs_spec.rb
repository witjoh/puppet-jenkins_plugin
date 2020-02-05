require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::nodejs' do
  it do
    is_expected.to contain_jenkins__plugin('nodejs').with_version(%r{\d.*})
  end
end
