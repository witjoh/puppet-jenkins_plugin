require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::matrix_auth' do
  it do
    is_expected.to contain_jenkins__plugin('matrix-auth').with_version(/\d.*/)
  end
end
