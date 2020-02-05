require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::http_request' do
  xit do
    is_expected.to contain_jenkins_plugin__plugins__install_groovy('http-request')
  end

  ['http-request',
   'apache-httpcomponents-client-4-api'].each do |name|
    it do
      is_expected.to contain_jenkins__plugin(name).with_version(%r{\d.*})
    end
  end
end
