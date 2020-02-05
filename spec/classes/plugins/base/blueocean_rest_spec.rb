require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::blueocean_rest' do
  it do
    is_expected.to contain_jenkins__plugin('blueocean-rest').with_version(%r{\d.*})
  end
end
