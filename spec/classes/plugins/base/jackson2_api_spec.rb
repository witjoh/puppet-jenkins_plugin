require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::jackson2_api' do
  it do
    is_expected.to contain_jenkins__plugin('jackson2-api').with_version(%r{\d.*})
  end
end
