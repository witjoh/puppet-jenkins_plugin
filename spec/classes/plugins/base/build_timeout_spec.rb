require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::build_timeout' do
  it do
    is_expected.to contain_jenkins__plugin('build-timeout').with_version(%r{\d.*})
  end
end
