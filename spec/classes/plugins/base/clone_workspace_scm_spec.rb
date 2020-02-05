require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::clone_workspace_scm' do
  it do
    is_expected.to contain_jenkins__plugin('clone-workspace-scm').with_version(/\d.*/)
  end
end
