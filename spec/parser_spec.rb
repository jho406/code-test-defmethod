require 'rspec'
require_relative '../lib/parser'

RSpec.describe 'Parser' do
  context '.parse_csv' do
    it 'returns empty if called with empty str' do
      csv_str = ''
      results = Parser.parse_csv(csv_str)
      expect(results).to eql []

      csv_str = '   '
      results = Parser.parse_csv(csv_str)
      expect(results).to eql []
    end

    it 'parses a csv line if passed a single line of csv' do
      csv_str = 'foo, bar'

      results = Parser.parse_csv(csv_str)
      expect(results).to eql [['foo', 'bar']]
    end
  end
end
