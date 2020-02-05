require 'spec_helper'

describe 'Jenkins_plugin::Email' do
  describe 'valid handling' do
    [
      'name@example.com',
      'name.surname@example.com',
      'name-surname@example.com',
      'name_surname@example.com',
      'some text <name@example.com>',
      'dfjgk <name.surname@example.com>',
      '98djh478& <name-surname@example.com>',
      'dfjkadfd <name_surname@example.com>',
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
        'gibberige',
        '<name_surname@example.com>',
        'Robert Donhan bob@email.com',
        '98djh478& <name surname@example.com>',
        '@notquiteright.org',
        'mail?dfdg#@example.com',
      ].each do |value|
        describe value.inspect do
          it { is_expected.not_to allow_value(value) }
        end
      end
    end
  end
end
