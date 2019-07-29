require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::handy_uri_templates_2_api' do
  it do
    is_expected.to contain_jenkins__plugin('handy-uri-templates-2-api').with_version(/\d.*/)
  end
end
