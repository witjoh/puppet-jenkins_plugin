require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::credentials_binding' do
  it do
    is_expected.to contain_jenkins__plugin('credentials-binding').with_version(%r{\d.*})
  end
end
