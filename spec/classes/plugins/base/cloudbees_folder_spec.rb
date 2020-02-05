require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::cloudbees_folder' do
  it do
    is_expected.to contain_jenkins__plugin('cloudbees-folder').with_version(%r{\d.*})
  end
end
