require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::gitlab' do

  it do
    is_expected.to contain_jenkins_plugin__plugins__install_groovy('gitlab-plugin')
  end

  ['gitlab-plugin',
   'workflow-job',
   'workflow-support',
   'git',
   'git-client',
   'workflow-scm-step',
   'workflow-step-api',
   'workflow-step-api',
   'apache-httpcomponents-client-4-api',
   'jsch',
   'ssh-credentials',
   'scm-api',
   'mailer',
   'matrix-project',
   'display-url-api',
   'junit',
   'script-security',
   'workflow-api',
  ].each do | name |
    it do
      is_expected.to contain_jenkins__plugin(name).with_version(/\d.*/)
    end
  end
end
