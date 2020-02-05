require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::publish_over_ssh' do
  it do
    is_expected.to contain_jenkins__plugin('publish-over-ssh').with_version(%r{\d.*})
  end
end
