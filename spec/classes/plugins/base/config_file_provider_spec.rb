require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::config_file_provider' do
  it do
    is_expected.to contain_jenkins__plugin('config-file-provider').with_version(/\d.*/)
  end
end
