require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::matrix_project' do
  it do
    is_expected.to contain_jenkins__plugin('matrix-project').with_version(/\d.*/)
  end
end
