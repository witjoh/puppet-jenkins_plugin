require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::blueocean_rest_impl' do
  it do
    is_expected.to contain_jenkins__plugin('blueocean-rest-impl').with_version(/\d.*/)
  end
end
