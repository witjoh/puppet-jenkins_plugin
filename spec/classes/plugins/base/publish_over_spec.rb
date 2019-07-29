require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::publish_over' do
  it do
    is_expected.to contain_jenkins__plugin('publish-over').with_version(/\d.*/)
  end
end
