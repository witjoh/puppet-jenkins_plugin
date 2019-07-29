require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::config::plugins::lib' do
  
  it do
    is_expected.to contain_file('/usr/lib/jenkins/groovy/plugins/lib').with(
      ensure: 'directory',
      mode: '0750',
      owner: 'jenkins',
      group: 'jenkins',
    )
  end
  
  it do
    is_expected.to contain_file('/usr/lib/jenkins/groovy/plugins/lib/Plib.groovy').with(
      ensure: 'directory',
      mode: '0640',
      owner: 'jenkins',
      group: 'jenkins',
      source: 'puppet:///modules/jenkins_plugin/groovy/plugins/lib/Plib.groovy',
    )
  end
end
