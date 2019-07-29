require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::base::email_ext' do
  it do
    is_expected.to contain_jenkins__plugin('email-ext').with_version(/\d.*/)
  end
end
