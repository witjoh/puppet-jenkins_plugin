require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::display_url_api' do
  it do
    is_expected.to contain_jenkins__plugin('display-url-api').with_version(/\d.*/)
  end
end
