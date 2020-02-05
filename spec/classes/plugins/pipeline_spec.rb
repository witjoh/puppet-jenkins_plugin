require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::pipeline' do
  # structs is managed by the jenkins upstrem module
  [
    'workflow-aggregator',
    'lockable-resources',
    'workflow-api',
    'workflow-basic-steps',
    'workflow-cps-global-lib',
    'workflow-cps',
    'command-launcher',
    'workflow-durable-task-step',
    'workflow-job',
    'workflow-multibranch',
    'workflow-scm-step',
    'workflow-step-api',
    'pipeline-stage-view',
    'jackson2-api',
    'pipeline-input-step',
    'pipeline-build-step',
    'pipeline-milestone-step',
    'pipeline-stage-step',
    'pipeline-model-definition',
    'pipeline-model-extensions',
    'ace-editor',
    'jquery-detached',
    'durable-task',
    'docker-workflow',
    'docker-commons',
    'credentials-binding',
    'plain-credentials',
    'pipeline-model-api',
    'pipeline-model-declarative-agent',
    'pipeline-stage-tags-metadata',
    'cloudbees-folder',
    'workflow-support',
    'scm-api',
    'apache-httpcomponents-client-4-api',
    'mailer',
    'git-server',
    'git-client',
    'script-security',
    'branch-api',
    'jsch',
    'ssh-credentials',
    'authentication-tokens',
    'momentjs',
    'pipeline-rest-api',
    'handlebars',
    'pipeline-graph-analysis',
  ].each do |name|
    it do
      is_expected.to contain_jenkins__plugin(name).with_version(%r{\d.*})
    end
  end
end
