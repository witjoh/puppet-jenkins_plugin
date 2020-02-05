require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::ruby_runtime' do
  it do
    is_expected.to contain_jenkins__plugin('ruby-runtime').with_version(%r{\d.*})
  end
end
