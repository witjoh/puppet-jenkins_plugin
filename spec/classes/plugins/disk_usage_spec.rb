require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::disk_usage' do
  [
    'mailer',
    'disk-usage',
  ].each do | name |
    it do
      is_expected.to contain_jenkins__plugin(name).with_version(/\d.*/)
    end
  end
end
