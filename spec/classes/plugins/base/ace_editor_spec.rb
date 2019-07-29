require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::ace_editor' do
  it do
    is_expected.to contain_jenkins__plugin('ace-editor').with_version(/\d.*/)
  end
end
