require 'spec_helper'

describe 'stringify_undef' do
  it { is_expected.not_to eq(nil) }
  it { is_expected.to run.with_params.and_raise_error(Puppet::ParseError) }
  #  ['true', 'false', nil, :undef, ''].each do |invalid|
  #    it { is_expected.to run.with_params(invalid).and_raise_error(Puppet::ParseError) }
  #  end
  it { is_expected.to run.with_params('test', 'yes', 'no', 'maybe').and_raise_error(Puppet::ParseError) }
  it { is_expected.to run.with_params(0, 0, 1).and_raise_error(Puppet::ParseError) }
  it { is_expected.to run.with_params('test', true).and_raise_error(Puppet::ParseError) }
  it { is_expected.to run.with_params('test', 0).and_raise_error(Puppet::ParseError) }
  it { is_expected.to run.with_params(true).and_return(true) }
  it { is_expected.to run.with_params('test').and_return('test') }
  it { is_expected.to run.with_params(6).and_return(6) }
  it { is_expected.to run.with_params(true, 'yes').and_return(true) }
  it { is_expected.to run.with_params('test', 'yes').and_return('test') }
  it { is_expected.to run.with_params(6, 'yes').and_return(6) }
  it { is_expected.to run.with_params(nil, 'null').and_return('null') }
  it { is_expected.to run.with_params(nil).and_return('undef') }
  it { is_expected.to run.with_params('', 'null').and_return('null') }
  it { is_expected.to run.with_params('').and_return('undef') }
  it { is_expected.to run.with_params(:undef, 'null').and_return('null') }
  it { is_expected.to run.with_params(:undef).and_return('undef') }
end
