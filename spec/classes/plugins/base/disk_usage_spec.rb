require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::disk_usage' do
  it do
    is_expected.to contain_jenkins__plugin('disk-usage').with_version(/\d.*/)
  end
end
