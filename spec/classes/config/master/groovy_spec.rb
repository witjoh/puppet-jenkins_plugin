require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::config::master::groovy' do
  it do
    is_expected.to contain_jenkins_plugin__plugins__install_groovy('global')
  end
end
