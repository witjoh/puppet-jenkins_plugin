require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::build_pipeline' do

  ['build-pipeline-plugin',
   'parameterized-trigger',
   'conditional-buildstep',
   'run-condition',
   'matrix-project',
   'maven-plugin',
   'javadoc',
   'apache-httpcomponents-client-4-api',
   'jsch',
   'junit',
   'mailer',
   'jquery',
  ].each do | name |
    it do
      is_expected.to contain_jenkins__plugin(name).with_version(/\d.*/)
    end
  end

end
