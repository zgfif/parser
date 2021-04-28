# frozen_string_literal: true

require_relative '../../lib/parser'

RSpec.describe Parser do
  # please, change this variable to your nickname that was created during signup
  my_nickname = 'pavlik5727'

  before(:each) do
    @parser = Parser.new(ENV['GSM_EMAIL'], ENV['GSM_PASS'])
  end

  it 'should not be authorized' do
    expect(@parser.authorized?).to be_falsey
  end

  it 'should signin adn return link to profile' do
    result = @parser.signin
    expect(result).to be_instance_of(Capybara::Node::Element)
    expect(result.text(:all)).to_not eq('Log in')
    expect(result.text(:all)).to eq(my_nickname)
  end

  it 'should return data' do
    list = @parser.favorite_devices
    expect(list[0][:brand]).to eq('Realme')
    expect(list[4][:model]).to eq('Galaxy A52')
  end
end
