require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::http_request' do
  it do
    is_expected.to contain_jenkins__plugin('http-request').with_version(/\d.*/)
  end
end

