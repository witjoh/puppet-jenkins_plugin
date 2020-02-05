require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::token_macro' do
  it do
    is_expected.to contain_jenkins__plugin('token-macro').with_version(%r{\d.*})
  end
end
