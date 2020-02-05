require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::blueocean' do
  it do
    is_expected.to contain_jenkins__plugin('blueocean').with_version(%r{\d.*})
  end
end
