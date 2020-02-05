require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::blueocean_display_url' do
  it do
    is_expected.to contain_jenkins__plugin('blueocean-display-url').with_version(%r{\d.*})
  end
end
