require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::momentjs' do
  it do
    is_expected.to contain_jenkins__plugin('momentjs').with_version(%r{\d.*})
  end
end
