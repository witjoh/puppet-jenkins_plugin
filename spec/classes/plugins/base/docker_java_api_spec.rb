require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::docker_java_api' do
 
  it do
    is_expected.to contain_jenkins__plugin('docker-java-api').with_version(/\d.*/)
  end

end
