require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::clone_workspace_scm' do
  xit do
    is_expected.to contain_Jenkins_plugin__Plugins__Install_groovy('clone-workspacer-scm')
  end

  [ 
    'clone-workspace-scm',
  ].each do | name |
    it do
      is_expected.to contain_jenkins__plugin(name).with_version(/\d.*/)
    end
  end
end
