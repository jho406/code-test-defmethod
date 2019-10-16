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

    it 'parses a csv line if passed a single row with a single column' do
      csv_str = 'foo'

      results = Parser.parse_csv(csv_str)
      expect(results).to eql [['foo']]
    end

    it 'parses a csv line if passed a single line of csv' do
      csv_str = 'foo, bar'

      results = Parser.parse_csv(csv_str)
      expect(results).to eql [['foo', 'bar']]
    end

    it 'parses multiple csv lines if passed a single column of multiple lines' do
      csv_str = <<~CSV
      foo
      abc
      CSV

      results = Parser.parse_csv(csv_str)
      expect(results).to eql(
        [
          ['foo'],
          ['abc']
        ]
      )
    end

    it 'parses multiple csv lines if passed lines and rows' do
      csv_str = <<~CSV
      foo, bar
      abc, 123
      CSV

      results = Parser.parse_csv(csv_str)
      expect(results).to eql(
        [
          ['foo', 'bar'],
          ['abc', '123']
        ]
      )
    end

  end
end
