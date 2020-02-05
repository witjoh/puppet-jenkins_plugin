require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::gitlab_plugin' do
  it do
    is_expected.to contain_jenkins__plugin('gitlab-plugin').with_version(%r{\d.*})
  end
end
