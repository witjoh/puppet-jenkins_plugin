require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::jquery' do
  it do
    is_expected.to contain_jenkins__plugin('jquery').with_version(/\d.*/)
  end
end
