require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::blueocean_pipeline_scm_api' do
  it do
    is_expected.to contain_jenkins__plugin('blueocean-pipeline-scm-api').with_version(/\d.*/)
  end
end
