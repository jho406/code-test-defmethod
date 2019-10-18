require 'rspec'
require_relative '../lib/code_test'

RSpec.describe 'CodeTest::Input' do
  context '.parse' do
    it 'returns empty if called with empty str' do
      csv_str = ''
      headers = [:title]
      results = CodeTest::Input.parse(csv_str, headers)
      expect(results).to eql []

      csv_str = '   '
      results = CodeTest::Input.parse(csv_str, headers)
      expect(results).to eql []
    end

    it 'returns an array of empty objects if the headers are empty' do
      csv_str = 'foo'
      headers = []

      results = CodeTest::Input.parse(csv_str, headers)
      expect(results).to eql [{}]
    end

    it 'parses a csv line if passed a single row with a single column' do
      csv_str = 'foo'
      headers = [:title]

      results = CodeTest::Input.parse(csv_str, headers)
      expect(results).to eql [{title: 'foo'}]
    end

    it 'parses a csv line if passed a single line of csv' do
      csv_str = 'foo,bar'
      headers = [:title, :body]

      results = CodeTest::Input.parse(csv_str, headers)
      expect(results).to eql [{title: 'foo', body: 'bar'}]
    end

    it 'parses multiple csv lines if passed a single column of multiple lines' do
      csv_str = <<~CSV
      foo
      abc
      CSV

      headers = [:title]

      results = CodeTest::Input.parse(csv_str, headers)
      expect(results).to eql(
        [
          {title: 'foo'},
          {title: 'abc'}
        ]
      )
    end

    it 'parses multiple csv lines if passed lines and rows' do
      csv_str = <<~CSV
      foo,bar
      abc,123
      CSV

      headers = [:title, :body]

      results = CodeTest::Input.parse(csv_str, headers)
      expect(results).to eql(
        [
          {title: 'foo', body: 'bar'},
          {title: 'abc', body: '123'}
        ]
      )
    end

    it 'leaves the values as nil if there are not enough rows' do
      csv_str = 'john'
      headers = [:first_name, :last_name]

      results = CodeTest::Input.parse(csv_str, headers)
      expect(results).to eql [{first_name: 'john', last_name: nil}]
    end

    it 'leaves off the extra values if there are too many columns and not enough headers' do
      csv_str = 'john,extra'
      headers = [:first_name]

      results = CodeTest::Input.parse(csv_str, headers)
      expect(results).to eql [{first_name: 'john'}]
    end

    it 'allows for different kind of delimiters' do
      csv_str = <<~PIPE
      foo|bar
      PIPE
      headers = [:title, :body]

      results = CodeTest::Input.parse(csv_str, headers, '|')
      expect(results).to eql(
        [
          {title: 'foo', body: 'bar'}
        ]
      )
    end

    it 'allows for a space delimiter' do
      csv_str = <<~SPACE
      foo bar
      SPACE
      headers = [:title, :body]

      results = CodeTest::Input.parse(csv_str, headers, ' ')
      expect(results).to eql(
        [
          {title: 'foo', body: 'bar'}
        ]
      )
    end
  end

  context '.parse_from_file' do
    it 'reads from a filepath and parses it, defaulting to CSV' do
      sample_csv = File.join(File.dirname(__FILE__), 'fixtures/comma.txt')
      headers = [:title, :body]
      result = CodeTest::Input.parse_from_file(sample_csv, headers)

      expect(result).to eql(
        [
          {title: 'john', body: 'smith'},
          {title: 'jason', body: 'smithers'}
        ]
      )
    end

    it 'reads from a filepath and parses it with an explicit delimiter' do
      sample_pound = File.join(File.dirname(__FILE__), 'fixtures/pound.txt')
      headers = [:title, :body]
      result = CodeTest::Input.parse_from_file(
        sample_pound, headers, '#'
      )

      expect(result).to eql(
        [
          {title: 'john', body: 'smith'},
          {title: 'jason', body: 'smithers'}
        ]
      )
    end
  end
end
