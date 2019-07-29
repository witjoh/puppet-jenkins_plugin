require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::blueocean_i18n' do
  it do
    is_expected.to contain_jenkins__plugin('blueocean-i18n').with_version(/\d.*/)
  end
end
