require 'rspec'
require_relative '../lib/code_test'

RSpec.describe 'CodeTest::Input' do
  context '.parse' do
    it 'returns empty if called with empty str' do
      csv_str = ''
      results = CodeTest::Input.parse(csv_str)
      expect(results).to eql []

      csv_str = '   '
      results = CodeTest::Input.parse(csv_str)
      expect(results).to eql []
    end

    it 'parses a csv line if passed a single row with a single column' do
      csv_str = 'foo'

      results = CodeTest::Input.parse(csv_str)
      expect(results).to eql [['foo']]
    end

    it 'parses a csv line if passed a single line of csv' do
      csv_str = 'foo,bar'

      results = CodeTest::Input.parse(csv_str)
      expect(results).to eql [['foo', 'bar']]
    end

    it 'parses multiple csv lines if passed a single column of multiple lines' do
      csv_str = <<~CSV
      foo
      abc
      CSV

      results = CodeTest::Input.parse(csv_str)
      expect(results).to eql(
        [
          ['foo'],
          ['abc']
        ]
      )
    end

    it 'parses multiple csv lines if passed lines and rows' do
      csv_str = <<~CSV
      foo,bar
      abc,123
      CSV

      results = CodeTest::Input.parse(csv_str)
      expect(results).to eql(
        [
          ['foo', 'bar'],
          ['abc', '123']
        ]
      )
    end

    it 'parses as multiple lines of arrays when passes a bad headers' do
      csv_str = 'foo'
      headers = 'invalid'

      results = CodeTest::Input.parse(csv_str, headers: headers)
      expect(results).to eql [['foo']]
    end

    it 'parses as lines of hashes when passes headers' do
      csv_str = 'john'
      headers = [:first_name]

      results = CodeTest::Input.parse(csv_str, headers: headers)
      expect(results).to eql [{first_name: 'john'}]
    end

    it 'leaves the values as nil if there are not enough rows' do
      csv_str = 'john'
      headers = [:first_name, :last_name]

      results = CodeTest::Input.parse(csv_str, headers: headers)
      expect(results).to eql [{first_name: 'john', last_name: nil}]
    end

    it 'leaves off the extra values if there are too many columns and not enough headers' do
      csv_str = 'john,extra'
      headers = [:first_name]

      results = CodeTest::Input.parse(csv_str, headers: headers)
      expect(results).to eql [{first_name: 'john'}]
    end

    it 'allows for different kind of delimiters' do
      csv_str = <<~PIPE
      foo|bar
      PIPE

      results = CodeTest::Input.parse(csv_str, delimiter: '|')
      expect(results).to eql(
        [
          ['foo', 'bar'],
        ]
      )
    end

    it 'allows for a space delimiter' do
      csv_str = <<~SPACE
      foo bar
      SPACE

      results = CodeTest::Input.parse(csv_str, delimiter: ' ')
      expect(results).to eql(
        [
          ['foo', 'bar'],
        ]
      )
    end
  end

  context '.parse_from_file' do
    it 'reads from a filepath and parses it, defaulting to CSV' do
      sample_csv = File.join(File.dirname(__FILE__), 'fixtures/comma.txt')
      result = CodeTest::Input.parse_from_file(sample_csv)

      expect(result).to eql(
        [
          ['john', 'smith'],
          ['jason', 'smithers'],
        ]
      )
    end

    it 'reads from a filepath and parses it with an explicit delimiter and headers' do
      sample_pound = File.join(File.dirname(__FILE__), 'fixtures/pound.txt')
      result = CodeTest::Input.parse_from_file(sample_pound, {
        delimiter: '#',
        headers: [:first_name, :last_name]
      })

      expect(result).to eql(
        [
          {first_name: 'john', last_name: 'smith'},
          {first_name: 'jason', last_name: 'smithers'}
        ]
      )
    end
  end
end