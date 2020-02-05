require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::h2_api' do
  it do
    is_expected.to contain_jenkins__plugin('h2-api').with_version(%r{\d.*})
  end
end
