require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::generic_webhook_trigger' do
  it do
    is_expected.to contain_jenkins__plugin('generic-webhook-trigger').with_version(%r{\d.*})
  end
end
