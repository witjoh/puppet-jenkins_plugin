require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::blueocean_config' do
  it do
    is_expected.to contain_jenkins__plugin('blueocean-config').with_version(%r{\d.*})
  end
end
