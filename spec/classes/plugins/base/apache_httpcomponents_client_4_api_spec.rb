require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::apache_httpcomponents_client_4_api' do
  it do
    is_expected.to contain_jenkins__plugin('apache-httpcomponents-client-4-api').with_version(/\d.*/)
  end
end
