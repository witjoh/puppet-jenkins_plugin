require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::workflow_job' do
  it do
    is_expected.to contain_jenkins__plugin('workflow-job').with_version(/\d.*/)
  end
end
