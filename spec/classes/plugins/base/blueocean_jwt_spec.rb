require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::blueocean_jwt' do
  it do
    is_expected.to contain_jenkins__plugin('blueocean-jwt').with_version(%r{\d.*})
  end
end
