require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::build_publisher' do
  xit do
    is_expected.to contain_Jenkins_plugin__Plugins__Install_groovy('build-publisher')
  end

  [ 'build-publisher',
    'maven-plugin',
    'junit',
    'apache-httpcomponents-client-4-api',
    'javadoc',
    'mailer',
    'token-macro',
    'jsch',
    'ssh-credentials',
    'credentials',
    'trilead-api',
    'structs',
    'workflow-api',
    'workflow-step-api',
    'script-security',
    'scm-api',
    'display-url-api',
    'matrix-project',
  ].each do | name |
    it do
      is_expected.to contain_jenkins__plugin(name).with_version(/\d.*/)
    end
  end
end
