require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::ssh' do
  it do
    is_expected.to contain_jenkins__plugin('ssh').with_version(%r{\d.*})
  end
end
