require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::docker' do
  xit do
    is_expected.to contain_jenkins_plugin__plugins__install_groovy('`docker')
  end

  [ 'docker-plugin',
    'docker-commons',
    'apache-httpcomponents-client-4-api',
    'bouncycastle-api',
    'docker-java-api',
    'durable-task',
    'ssh-slaves',
    'token-macro',
    'credentials',
    'ssh-credentials',
    'jackson2-api',
    'structs',
    'authentication-tokens',
    'credentials-binding',
    'workflow-step-api',
    'plain-credentials',
  ].each do | name |
    it do
      is_expected.to contain_jenkins__plugin(name).with_version(/\d.*/)
    end
  end
end
