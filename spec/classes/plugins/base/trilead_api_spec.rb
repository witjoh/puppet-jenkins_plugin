require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::trilead_api' do
  it do
    is_expected.to contain_jenkins__plugin('trilead-api').with_version(%r{\d.*})
  end
end
