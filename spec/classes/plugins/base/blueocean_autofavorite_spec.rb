require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::blueocean_autofavorite' do
  it do
    is_expected.to contain_jenkins__plugin('blueocean-autofavorite').with_version(%r{\d.*})
  end
end
