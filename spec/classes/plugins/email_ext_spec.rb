require 'spec_helper'
require 'shared_contexts'

describe 'jenkins_plugin::plugins::email_ext' do
  ['email-ext',
   'script-security',
   'junit',
   'mailer',
   'matrix-project',
   #   'structs',
   'token-macro'].each do |name|
    it do
      is_expected.to contain_jenkins__plugin(name).with_version(%r{\d.*})
    end
  end
end
