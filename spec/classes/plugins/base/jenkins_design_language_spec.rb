require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::jenkins_design_language' do
  it do
    is_expected.to contain_jenkins__plugin('jenkins-design-language')
  end
end
