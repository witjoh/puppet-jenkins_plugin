require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::htmlpublisher' do
  it do
    is_expected.to contain_jenkins__plugin('htmlpublisher').with_version(/\d.*/)
  end
end
