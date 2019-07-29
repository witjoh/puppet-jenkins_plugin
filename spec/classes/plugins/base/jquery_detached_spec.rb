require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::jquery_detached' do
  it do
    is_expected.to contain_jenkins__plugin('jquery-detached').with_version(/\d.*/)
  end
end
