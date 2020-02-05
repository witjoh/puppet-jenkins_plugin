require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::authentication_tokens' do
  it do
    is_expected.to contain_jenkins__plugin('authentication-tokens').with_version(%r{\d.*})
  end
end
