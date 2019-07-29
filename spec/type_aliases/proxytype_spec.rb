require 'spec_helper'

describe 'Jenkins_plugin::Proxytype' do
  describe 'valid handling' do
    [
      'http',
      'HTTP',
      'sock4',
      'sock5',
      'SOCK4',
      'SOCK5',
    ].each do |value|
      describe value.inspect do
        it { is_expected.to allow_value(value) }
      end
    end
  end

  describe 'invalid path handling' do
    context 'with garbage inputs' do
      [
        'hTtP',
        'SoCkS5',
        'SoCks4',
        'https',
        'HTTPS',
        'socks5',
        'socks4',
        'socks8',
        'SOCKS4',
        'SOCKS5',
        'SOCKS8',
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
