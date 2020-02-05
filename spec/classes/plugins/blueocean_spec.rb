require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::blueocean' do
  [
    'apache-httpcomponents-client-4-api',
    'blueocean',
    'blueocean-autofavorite',
    'blueocean-bitbucket-pipeline',
    'blueocean-commons',
    'blueocean-config',
    'blueocean-core-js',
    'blueocean-dashboard',
    'blueocean-display-url',
    'blueocean-events',
    'blueocean-github-pipeline',
    'blueocean-git-pipeline',
    'blueocean-i18n',
    'blueocean-jira',
    'blueocean-jwt',
    'blueocean-personalization',
    'blueocean-pipeline-api-impl',
    'blueocean-pipeline-editor',
    'blueocean-pipeline-scm-api',
    'blueocean-rest',
    'blueocean-rest-impl',
    'blueocean-web',
    'bouncycastle-api',
    'branch-api',
    'cloudbees-bitbucket-branch-source',
    'cloudbees-folder',
    'command-launcher',
    'credentials',
    'display-url-api',
    'favorite',
    'git',
    'git-client',
    'github',
    'github-api',
    'github-branch-source',
    'handy-uri-templates-2-api',
    'htmlpublisher',
    'jackson2-api',
    'jdk-tool',
    'jenkins-design-language',
    'jira',
    'junit',
    'mailer',
    'matrix-project',
    'mercurial',
    'pipeline-build-step',
    'pipeline-graph-analysis',
    'pipeline-input-step',
    'pipeline-milestone-step',
    'pipeline-model-definition',
    'pipeline-stage-step',
    'pipeline-stage-tags-metadata',
    'plain-credentials',
    'pubsub-light',
    'scm-api',
    'script-security',
    'sse-gateway',
    'token-macro',
    'variant',
    'workflow-api',
    'workflow-cps',
    'workflow-durable-task-step',
    'workflow-job',
    'workflow-multibranch',
    'workflow-step-api',
    'workflow-support',
  ].each do |name|
    it do
      is_expected.to contain_jenkins__plugin(name).with_version(%r{\d.*})
    end
  end
end
