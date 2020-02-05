require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::blueocean_personalization' do
  it do
    is_expected.to contain_jenkins__plugin('blueocean-personalization').with_version(%r{\d.*})
  end
end
