require 'spec_helper'

describe 'Jenkins_plugin::LDAPUrl' do
  describe 'valid handling' do
    [
      'ldap://hello.com',
      'ldaps://notcreative.org',
      'LDAP://notexciting.co.uk',
      'LDAPS://graphemica.com',
      'graphemica.com',
      'some.host.com',
      'FOO.com:123',
      'ldaps://ldap.example.com:526',
      'ldAPS://ldap.example.COM:526',
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
        'httds://notquiteright.org',
        'hptts:/nah',
        'https;//notrightbutclose.org',
        'http://graphemica.com/❤',
        'http://graphemica.com/緩',
      ].each do |value|
        describe value.inspect do
          it { is_expected.not_to allow_value(value) }
        end
      end
    end
  end
end
