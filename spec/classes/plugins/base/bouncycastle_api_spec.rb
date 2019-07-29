require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::bouncycastle_api' do
  it do
    is_expected.to contain_jenkins__plugin('bouncycastle-api').with_version(/\d.*/)
  end
end
