require 'rspec'
require_relative '../lib/parser'

RSpec.describe 'Parser' do
  context '.parse_csv' do
    it 'returns empty if called with empty str' do
      csv_str = ''
      results = Parser.parse_csv(csv_str)
      expect(results).to eql []
    end
  end
end
