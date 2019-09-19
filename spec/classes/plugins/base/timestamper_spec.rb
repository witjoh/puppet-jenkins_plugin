require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::timestamper' do
  it do
    is_expected.to contain_jenkins__plugin('timestamper').with_version(/\d.*/)
  end
end
