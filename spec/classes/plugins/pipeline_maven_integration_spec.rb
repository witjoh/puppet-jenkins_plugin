require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::pipeline_maven_integration' do
  [
    'pipeline-maven',
    'workflow-job',
    'workflow-step-api',
    'branch-api',
    'cloudbees-folder',
    'config-file-provider',
    'workflow-api',
    'script-security',
    'scm-api',
    'ssh-credentials',
    'token-macro',
    'workflow-support',
    'h2-api',
  ].each do |name|
    it do
      is_expected.to contain_jenkins__plugin(name).with_version(%r{\d.*})
    end
  end
end
