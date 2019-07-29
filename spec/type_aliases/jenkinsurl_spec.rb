require 'spec_helper'

describe 'Jenkins_plugin::JenkinsUrl' do
  describe 'valid handling' do
    [
      'http://hello.com',
      'https://notcreative.org',
      'HTTP://notexciting.co.uk',
      'HTTPS://graphemica.com',
      'Http://graphemica.com/jenkins',
      'https://some.host.com:25/foo',
      'hTTpS://FOO.com:123',
      'HtTp://ldap.example.com:526',
      'Https://ldap.example.COM:526',
    ].each do |value|
      describe value.inspect do
        it { is_expected.to allow_value(value) }
      end
    end
  end

  describe 'invalid path handling' do
    context 'with garbage inputs' do
      [
        nil,
        [nil],
        [nil, nil],
        { 'foo' => 'bar' },
        {},
        '',
        'lda://gibberige',
        'gibberige',
        'https://foo.dom:ad/jenkins',
        'http://foot.com:/foo',
        'httds://notquiteright.org',
        'hptts:/nah',
        'https;//notrightbutclose.org',
      ].each do |value|
        describe value.inspect do
          it { is_expected.not_to allow_value(value) }
        end
      end
    end
  end
end
