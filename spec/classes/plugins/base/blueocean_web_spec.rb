require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::blueocean_web' do
  it do
    is_expected.to contain_jenkins__plugin('blueocean-web').with_version(%r{\d.*})
  end
end
