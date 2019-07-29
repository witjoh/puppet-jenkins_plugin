require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::blueocean_core_js' do
  it do
    is_expected.to contain_jenkins__plugin('blueocean-core-js').with_version(/\d.*/)
  end
end
