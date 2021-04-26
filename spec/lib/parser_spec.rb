# frozen_string_literal: true

require_relative '../../lib/parser'

RSpec.describe Parser do
  before(:each) do
    @parser = Parser.new(ENV['GSM_EMAIL'], ENV['GSM_PASS'])
  end

  it 'should return mechanize link text' do
    result = @parser.signin
    expect(result).to be_instance_of(Mechanize::Page::Link)
    expect(result.text).to eq('pavlik5727')
  end

  it 'should return data' do
    list = @parser.favorite_devices
    expect(list[0][:brand]).to eq('Realme')
    expect(list[4][:model]).to eq('Galaxy A52')
  end
end
