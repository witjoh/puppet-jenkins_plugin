require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::handlebars' do
  it do
    is_expected.to contain_jenkins__plugin('handlebars').with_version(%r{\d.*})
  end
end
