require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::envinject' do
  it do
    is_expected.to contain_jenkins__plugin('envinject').with_version(%r{\d.*})
  end
end
