require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::blueocean_events' do
  it do
    is_expected.to contain_jenkins__plugin('blueocean-events').with_version(/\d.*/)
  end
end
