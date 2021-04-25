require_relative '../../lib/parser'

RSpec.describe Parser do
  describe '#log in' do
    it 'should return some text' do
      parser = Parser.new
      expect(parser.log_in).to eq('some text')
    end
  end

  describe '#retrieve_data' do
    it 'should return data' do
      parser = Parser.new
      expect(parser.retrieve_data).to eq('data')
    end
  end
end
