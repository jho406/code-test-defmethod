require 'rspec'

RSpec.describe 'Parser' do
  context '.parse_csv' do
    it 'returns empty if called with empty obj' do
      results = Parser.parse_csv()
      expect(results).to eql []
    end
  end
end
